
import UIKit

class moviePosterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    static let identifier = "moviePosterCollectionViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "moviePosterCollectionViewCell", bundle: nil)
    }
    
    
}
