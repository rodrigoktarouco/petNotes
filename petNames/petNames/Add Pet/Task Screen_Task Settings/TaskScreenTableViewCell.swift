//
//  TaskScreenTableViewCell.swift
//  petNames
//
//  Created by Enzo Degrazia on 19/10/21.
//

import UIKit

class TaskScreenTableViewCell: UITableViewCell {

    @IBOutlet var taskTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
