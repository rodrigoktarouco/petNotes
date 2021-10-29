//
//  repeatTableViewCell.swift
//  petNames
//
//  Created by Enzo Degrazia on 28/10/21.
//

import UIKit

class repeatTableViewCell: UITableViewCell {

    @IBOutlet var repeatLabel: UILabel!
    @IBOutlet var repeatSecondaryLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
