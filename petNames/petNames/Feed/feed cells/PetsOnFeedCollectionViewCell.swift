//
//  PetsOnFeedCollectionViewCell.swift
//  petNames
//
//  Created by Heitor Feijó Kunrath on 29/10/21.
//

import UIKit

class PetsOnFeedCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var petImageHeight: NSLayoutConstraint!
    @IBOutlet weak var petName: UILabel!
    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var auxBackGroundView: UIView!
    @IBOutlet weak var petTaskQuantity: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 22
        setUpLabelsDetails()
//        petImageHeight.constant = self.contentView.frame.height * 67 / 110 - 20
//        switch traitCollection.userInterfaceStyle {
//        case .light, .unspecified:
//            auxBackGroundView.backgroundColor = UIColor(red: 0.813, green: 0.904, blue: 1, alpha: 1)
//        case.dark:
//            auxBackGroundView.backgroundColor = UIColor(red: 0.717, green: 0.852, blue: 1, alpha: 1)
//        default:
//            break
//        }
    }
    func setUpLabelsDetails() {

        petName.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        petName.font = UIFont(name: "SFProRounded-Semibold", size: UIScreen.main.bounds.height * 12.1 / 560)

        petTaskQuantity.textColor = UIColor(red: 0.385, green: 0.385, blue: 0.385, alpha: 1)
        petTaskQuantity.font = UIFont(name: "SFProRounded-Regular", size: 14)

    }

}
