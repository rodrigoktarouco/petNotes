//
//  ContactTableViewCell.swift
//  petNames
//
//  Created by Heitor Feijó Kunrath on 22/10/21.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var contactTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
//        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
        contactTitleLabel.text = "contact".localized()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
