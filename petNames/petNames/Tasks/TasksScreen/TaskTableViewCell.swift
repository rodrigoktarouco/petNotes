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
    
    var clicked = false

    @IBAction func taskCheckedButton(_ sender: UIButton) {
                if clicked == false {
                taskCheckedImage.image = UIImage(systemName: "checkmark.circle.fill")
                taskCheckedImage.tintColor = UIColor(named: "CheckMarkClicked")
                clicked = true
                } else {
                    taskCheckedImage.image = UIImage(systemName: "checkmark.circle")
                    taskCheckedImage.tintColor = UIColor(named: "TC-checkMark")
                    clicked = false
                }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

//        petImageTask.layer.cornerRadius = 22

    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 22
        self.layer.masksToBounds = true

        self.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
