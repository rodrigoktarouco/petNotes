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
    @IBOutlet weak var petsCollectionView: UICollectionView!

    @IBOutlet weak var backgroundImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tasksCollectionView.dataSource = self
        petsCollectionView.dataSource = self
        setUpFontStyle()
        setUpLabelsTexts()
        setUpBackground()

        doneTasksFunImage.layer.cornerRadius = 22
    }
    func setUpBackground() {
        let backGroundAssetNames = ["background1", "background2", "background3"]
        backgroundImage.image = UIImage(named: backGroundAssetNames.randomElement() ?? "background1") ?? UIImage(named: "")
        backgroundImage.alpha = 0.4

        [tasksCollectionView, petsCollectionView].forEach { collection in collection?.backgroundColor = .clear}
    }
    func setUpLabelsTexts() {

        welcomeUserLabel.text = "welcomeUser".localized().capitalized + " " + FeedModel.sharedFeedModel.getUsersName() + "!"
        dayLabel.text = "today".localized().capitalized
        let tasks = "tasks".localized().capitalized
        doneTasksLabel.text = FeedModel.sharedFeedModel.getFractionOfNumberOfTasksDone() + " " + tasks
        nextTaskLabel.text = "nextTask".localized()
        myPetsLabel.text = "myPets"
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
        } else if collectionView == petsCollectionView {
            return 2

        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tasksCollectionView {
            let cell = tasksCollectionView.dequeueReusableCell(withReuseIdentifier: "NextTaskCollectionViewCell", for: indexPath) as? NextTaskCollectionViewCell
            guard let cell = cell else { return UICollectionViewCell() }
            let infoStruct = FeedModel.sharedFeedModel.getTaskFeedCollectionViewCellData(taskNumber: indexPath.row)
            cell.petImage.image = infoStruct.petImage
            cell.auxView.backgroundColor = FeedModel.sharedFeedModel.getTaskColor(infoStruct.taskType ?? .custom)
            cell.taskNameLabel.text = infoStruct.taskName?.capitalized
            cell.taskTimeLabel.text = infoStruct.taskTime
            cell.checkImage.image = infoStruct.done ?? false ? UIImage(systemName: "checkmark.circle") : UIImage(systemName: "checkmark.circle.fill")
            cell.checkImage.tintColor = UIColor(red: 0.592, green: 0.592, blue: 0.592, alpha: 1)
            return cell
        } else if collectionView == petsCollectionView {
            if indexPath.row == 0 {
                let cell = petsCollectionView.dequeueReusableCell(withReuseIdentifier: "AddNewPetCollectionViewCell", for: indexPath) as? AddNewPetCollectionViewCell
                return cell ?? UICollectionViewCell()
            }
            else {
                let cell = petsCollectionView.dequeueReusableCell(withReuseIdentifier: "PetsOnFeedCollectionViewCell", for: indexPath) as? PetsOnFeedCollectionViewCell
                let infoStruct = FeedModel.sharedFeedModel.getPetsCollectionViewData(petNumber: indexPath.row)
                cell?.petImage.image = infoStruct.petImage ?? UIImage()
                cell?.petName.text = infoStruct.petName?.capitalized

                cell?.petTaskQuantity.text = "tasks".localized().capitalized + " " + String(infoStruct.tasksQuantity ?? 0)
                return cell ?? UICollectionViewCell()
            }
            
        }
        return UICollectionViewCell()
    }

}
extension String {
    func localized() -> String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
