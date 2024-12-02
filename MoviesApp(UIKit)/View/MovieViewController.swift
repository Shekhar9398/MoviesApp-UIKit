import UIKit
import Kingfisher

class MovieViewController: UIViewController {
    
    var viewModel = MovieViewModel()
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        
        moviesCollectionView.register(moviePosterCollectionViewCell.nib(), forCellWithReuseIdentifier: moviePosterCollectionViewCell.identifier)
        
        viewModel.onMoviesUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.moviesCollectionView.reloadData()
            }
        }
        viewModel.fetchMovies()
        
        //Set title for HomeVc
        self.title = "Movies"

    }
}

extension MovieViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: moviePosterCollectionViewCell.identifier, for: indexPath) as! moviePosterCollectionViewCell
        
        let movie = viewModel.movies[indexPath.item]
        cell.movieTitle.text = movie.title
        
//        Convert stringUrl to Image
        if let url = URL(string: movie.posterURL){
            cell.moviePoster.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        }

        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 270)
    }
    
    //Navigation to item details
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
        
        vc.indexCarry = indexPath
    
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
