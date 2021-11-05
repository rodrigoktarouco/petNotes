//
//  TasksEnumerationTableViewCell.swift
//  petNames
//
//  Created by Heitor Feijó Kunrath on 03/11/21.
//

import UIKit

class TasksEnumerationTableViewCell: UITableViewCell {
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var taskImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        fontStyle()
    }
    func fontStyle() {
        taskName.font = UIFont(name: "SFProRounded-Regular", size: 17)
        taskName.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
