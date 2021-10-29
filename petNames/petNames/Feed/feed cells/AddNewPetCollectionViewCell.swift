//
//  AddNewPetCollectionViewCell.swift
//  petNames
//
//  Created by Heitor Feijó Kunrath on 29/10/21.
//

import UIKit

class AddNewPetCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var addNewPet: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        addNewPet.font = UIFont(name: "SFProRounded-Semibold", size: 20)
        addNewPet.text = "addNewPet".localized()
        self.layer.cornerRadius = 22
    }


}
