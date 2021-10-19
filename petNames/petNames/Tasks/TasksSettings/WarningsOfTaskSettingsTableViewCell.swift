//
//  WarningsOfTaskSettingsTableViewCell.swift
//  petNames
//
//  Created by Heitor Feijó Kunrath on 19/10/21.
//

import UIKit

class WarningsOfTaskSettingsTableViewCell: UITableViewCell {
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var isOn: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
