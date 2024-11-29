import UIKit
import Kingfisher

class MovieDetailsViewController: UIViewController {
    
    var indexCarry: IndexPath?
    var viewModel = MovieViewModel()
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Movie Details"
        
        // Bind to the view model's data update callback
        viewModel.onMoviesUpdated = { [weak self] in
            self?.displayImageDetails()
        }
        
        // Fetch movies
        viewModel.fetchMovies()
        
        // Debugging indexCarry
        if let row = indexCarry?.row {
            print("Index is \(row)")
        } else {
            print("Index is nil")
        }
    }
    
    func displayImageDetails() {
        let movies = viewModel.movies
        
        // Validate `indexCarry` and ensure index is within bounds
        guard let index = indexCarry?.row, index >= 0, index < movies.count else {
            print("Invalid or out-of-bounds indexCarry")
            return
        }
        
        let selectedMovie = movies[index]
        
        // Update the UI on the main thread
        DispatchQueue.main.async {
            self.movieName.text = selectedMovie.title
            
            if let posterUrl = URL(string: selectedMovie.posterURL) {
                self.moviePoster.kf.setImage(
                    with: posterUrl,
                    placeholder: UIImage(named: "placeholder"),
                    options: nil,
                    completionHandler: { result in
                        switch result {
                        case .success:
                            print("Image successfully loaded")
                        case .failure(let error):
                            print("Error loading image: \(error.localizedDescription)")
                        }
                    }
                )
            } else {
                print("Invalid poster URL")
            }
        }
    }
}
