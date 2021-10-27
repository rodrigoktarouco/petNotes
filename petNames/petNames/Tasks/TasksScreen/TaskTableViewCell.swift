//
//  TaskTableViewCell.swift
//  petNames
//
//  Created by Rodrigo Kroef Tarouco on 18/10/21.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var petImageTask: UIImageView!
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var taskTimeLabel: UILabel!
    @IBOutlet weak var petNameLabel: UILabel!
    @IBOutlet weak var taskCheckedImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
