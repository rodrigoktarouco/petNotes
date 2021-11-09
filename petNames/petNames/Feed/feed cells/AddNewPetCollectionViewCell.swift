//
//  AddNewPetCollectionViewCell.swift
//  petNames
//
//  Created by Heitor Feijó Kunrath on 29/10/21.
//

import UIKit

class AddNewPetCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var addImage: UIImageView!
    @IBOutlet weak var addNewPet: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontSize: CGFloat  = UIScreen.main.bounds.width * 0.08 - 13 // (UIScreen.main.bounds.width * 14.2) / 320
        addNewPet.font = UIFont(name: "SFProRounded-Semibold", size: fontSize)
        addNewPet.text = "addNewPet".localized()
        self.layer.cornerRadius = 22

        }
    }



