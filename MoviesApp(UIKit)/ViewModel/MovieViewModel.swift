import UIKit

class MovieViewModel {
    private let movieUrl = "https://api.sampleapis.com/movies/animation"
    private(set) var movies: [MovieResponse] = []
    
    var onMoviesUpdated: (() -> Void)?
    
    func fetchMovies() {
        NetworkManager.shared.fetchData(from: movieUrl, modelType: [MovieResponse].self) { [weak self] result in
            switch result {
            case .success(let movieData):
                self?.movies = movieData
                self?.onMoviesUpdated?()
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
