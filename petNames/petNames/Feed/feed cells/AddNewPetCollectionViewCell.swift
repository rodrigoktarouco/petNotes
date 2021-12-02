//
//  AddNewPetCollectionViewCell.swift
//  petNames
//
//  Created by Heitor Feijó Kunrath on 29/10/21.
//

import UIKit

class AddNewPetCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var auxBackGroundView: UIView!
    @IBOutlet weak var addImage: UIImageView!
    @IBOutlet weak var addNewPet: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontSize: CGFloat  = UIScreen.main.bounds.width * 0.08 - 14 // (UIScreen.main.bounds.width * 14.2) / 320
        addNewPet.font = UIFont(name: "SFProRounded-Semibold", size: fontSize)
        addNewPet.text = "addNewPet".localized()
        self.layer.cornerRadius = 22

        switch traitCollection.userInterfaceStyle {
        case .light, .unspecified:
            auxBackGroundView.backgroundColor = UIColor(red: 0.813, green: 0.904, blue: 1, alpha: 1)
        case.dark:
            auxBackGroundView.backgroundColor = UIColor(red: 0.717, green: 0.852, blue: 1, alpha: 1)
        default:
            break
        }
    }
}
