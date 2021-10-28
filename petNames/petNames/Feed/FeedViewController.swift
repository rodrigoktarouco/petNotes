//
//  ViewController.swift
//  petNames
//
//  Created by Rodrigo Kroef Tarouco on 06/10/21.
//

import UIKit

class FeedViewController: UIViewController {
    
    @IBOutlet weak var welcomeUserLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var doneTasksLabel: UILabel!
    @IBOutlet weak var nextTaskLabel: UILabel!
    @IBOutlet weak var myPetsLabel: UILabel!
    
    @IBOutlet weak var doneTasksFunImage: UIImageView!
    @IBOutlet weak var tasksCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tasksCollectionView.dataSource = self
        setUpFontStyle ()
        doneTasksFunImage.layer.cornerRadius = 22
    }
    func setUpFontStyle () {
        welcomeUserLabel.font = UIFont(name: "SFProRounded-Bold", size: 24)
        dayLabel.font = UIFont(name: "SFProRounded-Medium", size: 14)
        dayLabel.textColor = .white
        doneTasksLabel.font = UIFont(name: "SFProRounded-Bold", size: 24)
        doneTasksLabel.textColor = .white
        nextTaskLabel.font = UIFont(name: "SFProRounded-Semibold", size: 20)
        myPetsLabel.font = UIFont(name: "SFProRounded-Semibold", size: 20)
    }
}
extension FeedViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tasksCollectionView {
            return 2
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tasksCollectionView {
            let cell = tasksCollectionView.dequeueReusableCell(withReuseIdentifier: "NextTaskCollectionViewCell", for: indexPath) as! NextTaskCollectionViewCell
            cell.taskTimeLabel.text = "teste"
            cell.petImage.image = UIImage(named: "pitty")
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}
extension String {
    func localized() -> String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
