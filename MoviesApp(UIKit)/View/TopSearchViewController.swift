import UIKit
import Kingfisher

class TopSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var movieSearchBar: UISearchBar!
    @IBOutlet weak var movieSearchTableView: UITableView!
    
    var viewModel = MovieViewModel()
    var allMovies: [MovieResponse] = []
    var filteredMovies: [MovieResponse] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieSearchTableView.delegate = self
        movieSearchTableView.dataSource = self
        movieSearchBar.delegate = self
        
        movieSearchTableView.register(MovieSearchTableViewCell.nib(), forCellReuseIdentifier: MovieSearchTableViewCell.identifier)
        
        bindViewModel()
        viewModel.fetchMovies()
    }
    
    private func bindViewModel() {
        viewModel.onMoviesUpdated = { [weak self] in
            DispatchQueue.main.async {
                // Populate allMovies with fetched data
                self?.allMovies = self?.viewModel.movies ?? []
                // Update the filteredMovies with the initial set of data
                self?.filteredMovies = self?.allMovies ?? []
                self?.movieSearchTableView.reloadData()
            }
        }
    }
    
    // UISearchBarDelegate method for search functionality
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterMovies(searchText: searchText)
    }
    
    // UISearchBarDelegate method for clearing search text
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        filterMovies(searchText: "")
    }
    
    // Function to filter movies based on the search text
    func filterMovies(searchText: String) {
        if searchText.isEmpty {
            filteredMovies = allMovies // If search text is empty, show all movies
        } else {
            filteredMovies = allMovies.filter { movie in
                movie.title.lowercased().contains(searchText.lowercased())
            }
        }
        
        // Reload the table view with the filtered data
        movieSearchTableView.reloadData()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieSearchTableView.dequeueReusableCell(withIdentifier: MovieSearchTableViewCell.identifier) as! MovieSearchTableViewCell
        
        let movie = filteredMovies[indexPath.row]
        cell.movieSearchName.text = movie.title
  
        if let imgUrl = URL(string: movie.posterURL){
            cell.movieSearchPoster.kf.setImage(with:imgUrl )
        }
            
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
