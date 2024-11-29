

import UIKit

class CommingSoonCollectionViewCell: UICollectionViewCell {
    
    var likeCount = 0
    
    @IBOutlet weak var likeLabel: UILabel!
    
    @IBOutlet weak var commingSoonPoster: UIImageView!
    
    @IBOutlet weak var likeButtonOutlet: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        likeLabel.text = "Likes \(likeCount)"
    }
    
    static let identifier = "CommingSoonCollectionViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "CommingSoonCollectionViewCell", bundle: nil)
    }
    
    @IBAction func likeButton(_ sender: UIButton) {
        likeCount += 1
        likeLabel.text = "Likes \(likeCount)"
    }
    

}
