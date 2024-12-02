//
//  DownloadTableViewCell.swift
//  MoviesApp(UIKit)
//
//  Created by Admin on 02/12/24.
//

import UIKit

class DownloadTableViewCell: UITableViewCell {

    
    @IBOutlet weak var downloadImageView: UIImageView!
    
    @IBOutlet weak var downloadButtonOutlet: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    static let identifier = "DownloadTableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "DownloadTableViewCell", bundle: nil)
    }
    
    
    @IBAction func downloadButton(_ sender: Any) {
    }
    
}
