//
//  ContactTableViewCell.swift
//  petNames
//
//  Created by Heitor Feijó Kunrath on 22/10/21.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var instagramImage: UIImageView!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var mailLabel: UIView!
    @IBOutlet weak var instagramLabel: UILabel!
    
    @IBOutlet weak var insideView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
        instagramImage.image = UIImage(named: "instagramSymbol")
        insideView.layer.cornerRadius = 12
        contactLabel.text = "contact".localized()
        contactLabel.font = UIFont(name: "SFProRounded-Semibold", size: 20)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
