//
//  ShareTableViewCell.swift
//  petNames
//
//  Created by Guilherme Valent Antonini on 18/10/21.
//

import UIKit

class ShareTableViewCell: UITableViewCell {

    @IBOutlet weak var shareLabel: UILabel!
    @IBOutlet weak var shareImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
