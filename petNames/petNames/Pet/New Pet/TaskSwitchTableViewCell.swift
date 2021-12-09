//
//  TaskSwitchTableViewCell.swift
//  petNames
//
//  Created by Guilherme Valent Antonini on 11/11/21.
//

import UIKit

protocol TaskSwitchTableViewCellDelegate: AnyObject {
    func didToogleTaskSwitch(taskID: String, enabled: Bool)
}
class TaskSwitchTableViewCell: UITableViewCell {

    @IBOutlet weak var taskIconImage: UIImageView!
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet public weak var taskSwitch: UISwitch!
    var taskID: String = ""
    weak var delegate: TaskSwitchTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func didToogleSwitchTask(_ sender: UISwitch) {
        delegate?.didToogleTaskSwitch(taskID: taskID, enabled: sender.isOn)
    }

}
