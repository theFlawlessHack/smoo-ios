//
//  FeedTableViewCell.swift
//  
//
//  Created by Jessica Joseph on 1/30/18.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    @IBOutlet weak var postedImage: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!    
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
