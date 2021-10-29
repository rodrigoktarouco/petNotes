//
//  PetsOnFeedCollectionViewCell.swift
//  petNames
//
//  Created by Heitor Feijó Kunrath on 29/10/21.
//

import UIKit

class PetsOnFeedCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var petName: UILabel!
    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var petTaskQuantity: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 22
        setUpLabelsDetails()
    }
    func setUpLabelsDetails() {

        petName.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        petName.font = UIFont(name: "SFProRounded-Semibold", size: 17)

        petTaskQuantity.textColor = UIColor(red: 0.385, green: 0.385, blue: 0.385, alpha: 1)
        petTaskQuantity.font = UIFont(name: "SFProRounded-Regular", size: 14)

    }

}
