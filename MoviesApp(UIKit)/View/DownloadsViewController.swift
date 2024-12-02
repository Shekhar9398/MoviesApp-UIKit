import UIKit
import Kingfisher

class DownloadsViewController: UIViewController {
    
    @IBOutlet weak var downloadTableView: UITableView!
    
    var viewModel = MovieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register custom cell
        downloadTableView.register(DownloadTableViewCell.nib(), forCellReuseIdentifier: DownloadTableViewCell.identifier)
        downloadTableView.delegate = self
        downloadTableView.dataSource = self
        
        // Bind the view model's update callback
        viewModel.onMoviesUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.downloadTableView.reloadData()
            }
        }
        
        // Fetch movies
        viewModel.fetchMovies()
    }
}

extension DownloadsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count // Dynamically update based on movies fetched
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = downloadTableView.dequeueReusableCell(withIdentifier: DownloadTableViewCell.identifier, for: indexPath) as? DownloadTableViewCell else {
            return UITableViewCell()
        }
        
        // Configure cell with movie data
        let movie = viewModel.movies[indexPath.row]
        cell.downloadImageView.kf.setImage(with: URL(string: movie.posterURL), placeholder: UIImage(named: "placeholder"))
        
        cell.downloadButtonOutlet.tag = indexPath.row
        cell.downloadButtonOutlet.addTarget(self, action: #selector(downloadButtonTapped(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    // Handle download button action
    @objc func downloadButtonTapped(_ sender: UIButton) {
        let movieIndex = sender.tag
        guard movieIndex >= 0, movieIndex < viewModel.movies.count else {
            print("Invalid movie index")
            return
        }
        
        let movie = viewModel.movies[movieIndex]
        print("Download button tapped for movie: \(movie.title)")
        
        // Download movie poster
        guard let posterURL = URL(string: movie.posterURL) else {
            print("Invalid poster URL")
            showAlert(title: "Error", message: "Invalid poster URL.")
            return
        }
        
        KingfisherManager.shared.retrieveImage(with: posterURL) { result in
            switch result {
            case .success(let value):
                // Save image to photo library
                UIImageWriteToSavedPhotosAlbum(value.image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
                
                //Handle failure
            case .failure(let error):
                print("Failed to download image: \(error.localizedDescription)")
            }
        }
    }
    
    // Image saving callback
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // Error saving image
            print("Error saving image: \(error.localizedDescription)")
            showAlert(title: "Error", message: "Failed to save the image. Please try again.")
        } else {
            // Successfully saved image
            print("Image successfully saved to photo library")
            showAlert(title: "Success", message: "Image saved to your photo library.")
        }
    }
    
    // Helper method to show alert
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
