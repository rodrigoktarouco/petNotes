//
//  SharedWithTableViewCell.swift
//  petNames
//
//  Created by Guilherme Valent Antonini on 25/11/21.
//

import UIKit

class SharedWithTableViewCell: UITableViewCell {

    @IBOutlet weak var sharedWithLabel: UILabel!
    @IBOutlet weak var sharedWithImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
