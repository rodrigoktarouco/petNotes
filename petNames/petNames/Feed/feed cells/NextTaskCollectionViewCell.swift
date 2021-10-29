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

    override func awakeFromNib() {
        super.awakeFromNib()
        
        petImage.layer.cornerRadius = 15
        auxView.layer.cornerRadius = 22
        
        setUpFontStyle()
        auxView.backgroundColor = FeedModel.sharedFeedModel.getTaskColor(.medicine)
    }
    
    func setUpFontStyle () {
        taskNameLabel.font = UIFont(name: "SFProRounded-Semibold", size: 17)
        taskTimeLabel.font = UIFont(name: "SFProRounded-Regular", size: 10)
        
    }
    
}
