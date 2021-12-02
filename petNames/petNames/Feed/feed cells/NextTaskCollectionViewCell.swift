//
//  NextTaskCollectionViewCell.swift
//  petNames
//
//  Created by Heitor Feijó Kunrath on 28/10/21.
//

import UIKit

class NextTaskCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var taskTimeLabel: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    @IBOutlet weak var auxView: UIView!
    var taskNameInPersistence: String?
    @IBOutlet weak var auxViewWidth: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        petImage.layer.cornerRadius = 22
        auxView.layer.cornerRadius = 22
        auxView.clipsToBounds = true
        auxView.layer.borderWidth = 1

        setUpFontStyle()

        auxViewWidth.constant = UIScreen.main.bounds.width - 60
        
    }
    
    func setUpFontStyle () {
        taskNameLabel.font = UIFont(name: "SFProRounded-Semibold", size: 17)
        
        taskTimeLabel.font = UIFont(name: "SFProRounded-Regular", size: 14)
        
    }
}
