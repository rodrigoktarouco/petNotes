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

    override func awakeFromNib() {
        super.awakeFromNib()
        
        petImage.layer.cornerRadius = 22
        auxView.layer.cornerRadius = 22

        setUpColors()
        setUpFontStyle()

    }
    func setUpColors() {
        switch traitCollection.userInterfaceStyle {
        case .light, .unspecified:
            auxView.backgroundColor = TasksDesign.shared.getTaskDesignProperties(taskNameInPersistence ?? "").color

        case .dark:
            auxView.layer.borderWidth = 1
            auxView.layer.borderColor = TasksDesign.shared.getTaskDesignProperties(taskNameInPersistence ?? "").color?.cgColor
            auxView.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.114, alpha: 1)
        default:
            break
        }

        checkImage.tintColor = TasksDesign.shared.getTaskDesignProperties(taskNameInPersistence ?? "").color
    }
    func setUpFontStyle () {
        taskNameLabel.font = UIFont(name: "SFProRounded-Semibold", size: 17)
        
        taskTimeLabel.font = UIFont(name: "SFProRounded-Regular", size: 14)
        
    }
    
}
