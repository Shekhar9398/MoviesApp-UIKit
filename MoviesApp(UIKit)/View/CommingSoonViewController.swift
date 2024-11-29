
import UIKit

@available(iOS 15.4, *)
class CommingSoonViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var commingSoonCollectionView: UICollectionView!
    
    @IBOutlet weak var upcommingMovieHeading: UILabel!
    
    var upcommingMoviePoster = ["justSuper", "iceAgeRobots", "snoopy", "findingDorry", "theaterCouple"]
            
    override func viewDidLoad() {
        super.viewDidLoad()

        commingSoonCollectionView.delegate = self
        commingSoonCollectionView.dataSource = self
        
        commingSoonCollectionView.register(CommingSoonCollectionViewCell.nib(), forCellWithReuseIdentifier: CommingSoonCollectionViewCell.identifier)
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return upcommingMoviePoster.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = commingSoonCollectionView.dequeueReusableCell(withReuseIdentifier:CommingSoonCollectionViewCell.identifier, for: indexPath) as! CommingSoonCollectionViewCell
        
        cell.commingSoonPoster.image = UIImage(named: upcommingMoviePoster[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 300)
    }
}
