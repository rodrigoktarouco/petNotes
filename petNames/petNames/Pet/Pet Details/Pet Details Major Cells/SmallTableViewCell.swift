//
//  SmallTableViewCell.swift
//  petNames
//
//  Created by Heitor Feijó Kunrath on 04/11/21.
//

import UIKit

class SmallTableViewCell: UITableViewCell {

    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var taskImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        taskName.font = UIFont(name: "SFProRounded-Regular", size: 17)
        taskName.text = taskName.text?.capitalized
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
