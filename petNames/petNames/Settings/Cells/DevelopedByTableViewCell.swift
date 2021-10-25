//
//  DevelopedByTableViewCell.swift
//  petNames
//
//  Created by Heitor Feijó Kunrath on 25/10/21.
//

import UIKit

class DevelopedByTableViewCell: UITableViewCell {

    @IBOutlet weak var developedByLabel: UILabel!
    @IBOutlet weak var dharanaLabel: UILabel!
    @IBOutlet weak var enzoLabel: UILabel!
    @IBOutlet weak var guilhermeLabel: UILabel!
    @IBOutlet weak var heitorLabel: UILabel!
    @IBOutlet weak var rodrigoLabel: UILabel!
    
    @IBOutlet weak var insideView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
        insideView.layer.cornerRadius = 12
        setFontStyle()
        developedByLabel.text = "AppDevelopedBy".localized()
    }
    func setFontStyle(){
        developedByLabel.font = UIFont(name: "SFProRounded-Semibold", size: 20)
        let labels = [dharanaLabel,enzoLabel,guilhermeLabel,heitorLabel,rodrigoLabel]
        for label in labels {
            label?.font = UIFont(name: "SFProRounded-Regular", size: 14)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
