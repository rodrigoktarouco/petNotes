//
//  TaskSwitchTableViewCell.swift
//  petNames
//
//  Created by Guilherme Valent Antonini on 11/11/21.
//

import UIKit

class TaskSwitchTableViewCell: UITableViewCell {

    @IBOutlet weak var taskIconImage: UIImageView!
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var taskSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
