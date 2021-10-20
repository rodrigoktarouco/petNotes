//
//  AddANewAlertTableViewCell.swift
//  petNames
//
//  Created by Rodrigo Kroef Tarouco on 19/10/21.
//

import UIKit

class AddANewAlertTableViewCell: UITableViewCell {
    @IBOutlet weak var addANewAlertLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        addANewAlertLabel.text = "addANewAlertLabel".localized()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
