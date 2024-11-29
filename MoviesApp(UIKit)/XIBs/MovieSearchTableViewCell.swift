
import UIKit

class MovieSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var movieSearchPoster: UIImageView!
    
    @IBOutlet weak var movieSearchName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    static let identifier = "MovieSearchTableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "MovieSearchTableViewCell", bundle: nil)
    }
    
}
