//
//  ViewController.swift
//  petNames
//
//  Created by Rodrigo Kroef Tarouco on 06/10/21.
//

import UIKit
import AVFoundation

class FeedViewController: UIViewController {
    
    @IBOutlet weak var welcomeUserLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var doneTasksLabel: UILabel!
    @IBOutlet weak var nextTaskLabel: UILabel!
    @IBOutlet weak var myPetsLabel: UILabel!
    
    @IBOutlet weak var tasksCollectionView: UICollectionView!
    @IBOutlet weak var petsCollectionView: UICollectionView!

    @IBOutlet weak var doneTasksFunImage: UIImageView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!

    //Constraints

    @IBOutlet weak var welcomeUserTopDistance: NSLayoutConstraint!


    @IBOutlet weak var funimageTopDistance: NSLayoutConstraint!

    // @IBOutlet weak var funImageHeight: NSLayoutConstraint!

    @IBOutlet weak var dayLabelTopdistance: NSLayoutConstraint!

    @IBOutlet weak var doneTasksTopDistance: NSLayoutConstraint!

    let modelInstance: FeedModel = FeedModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tasksCollectionView.dataSource = self
        petsCollectionView.dataSource = self
        petsCollectionView.delegate = self
        setUpFontStyle()
        setUpLabelsTexts()
        setUpBackground()
        setUpDoneTasksImage()
        constraintAdjustments()

        logoImage.image = UIImage(named: "logo")
    }

    func constraintAdjustments() {
        welcomeUserTopDistance.constant = UIScreen.main.bounds.height * 23 / 844
        funimageTopDistance.constant = UIScreen.main.bounds.height * 10 / 844


        //        funImageHeight.constant = UIScreen.main.bounds.height * 80 / 844
        //        funImageWidth.constant = UIScreen.main.bounds.width * 330 / 844
        doneTasksTopDistance.constant =  0.0201*UIScreen.main.bounds.height - 10
        dayLabelTopdistance.constant = UIScreen.main.bounds.height * 21 / 844
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switch traitCollection.userInterfaceStyle {
        case .light, .unspecified:
            self.tabBarController?.tabBar.backgroundColor = UIColor(red: 0.957, green: 0.957, blue: 0.957, alpha: 0.5)
        default:
            break
        }

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        switch traitCollection.userInterfaceStyle {
        case .light, .unspecified:
            self.tabBarController?.tabBar.backgroundColor = UIColor(red: 0.957, green: 0.957, blue: 0.957, alpha: 1)
        default:
            
            break
        }

    }

    func setUpDoneTasksImage() {
        doneTasksFunImage.layer.cornerRadius = 22
        doneTasksFunImage.image =  modelInstance.getImageForFunTasksImageView()
    }

    func setUpBackground() {
        let backGroundAssetNames = ["background1", "background2", "background3"]
        backgroundImage.image = UIImage(named: backGroundAssetNames.randomElement() ?? "background1") ?? UIImage(named: "")
        backgroundImage.alpha = 0.4
        [tasksCollectionView, petsCollectionView].forEach { collection in collection?.backgroundColor = .clear}
    }

    func setUpLabelsTexts() {

        welcomeUserLabel.text = "welcomeUser".localized().capitalized + " " + modelInstance.getUsersName() + "!" + " 👋🏼"
        dayLabel.text = "today".localized().capitalized
        let tasks = "tasks".localized().lowercased()
        doneTasksLabel.text = modelInstance.getFractionOfNumberOfTasksDone() + " " + tasks
        nextTaskLabel.text = "nextTask".localized().capitalized
        myPetsLabel.text = "myPets".localized().capitalized
    }

    func setUpFontStyle () {

        welcomeUserLabel.font = UIFont(name: "SFProRounded-Bold", size: UIScreen.main.bounds.height*24/844)
        dayLabel.font = UIFont(name: "SFProRounded-Medium", size: UIScreen.main.bounds.height*14/844)
        dayLabel.textColor = .white
        doneTasksLabel.font = UIFont(name: "SFProRounded-Bold", size: UIScreen.main.bounds.height*24/844)
        doneTasksLabel.textColor = .white
        nextTaskLabel.font = UIFont(name: "SFProRounded-Semibold", size: UIScreen.main.bounds.height*14.2/568)
        myPetsLabel.font = UIFont(name: "SFProRounded-Semibold", size: UIScreen.main.bounds.height*14.2/568)
    }
}
extension FeedViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tasksCollectionView {
            return modelInstance.getNumberOfTotalTasks()
        } else if collectionView == petsCollectionView {
            return 1 + modelInstance.getNumberOfPets() // 1 + é para mostrar o adicionar pet além dos pets que já existem

        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tasksCollectionView {
            let cell = tasksCollectionView.dequeueReusableCell(withReuseIdentifier: "NextTaskCollectionViewCell", for: indexPath) as? NextTaskCollectionViewCell
            guard let cell = cell else { return UICollectionViewCell() }
            let infoStruct = modelInstance.getTaskFeedCollectionViewCellData(taskNumber: indexPath.row)
            cell.petImage.image = infoStruct.petImage
            cell.taskNameLabel.text = infoStruct.taskName?.capitalized
            cell.taskTimeLabel.text = infoStruct.taskTime
            cell.checkImage.image = infoStruct.done ?? false ? UIImage(systemName: "checkmark.circle") : UIImage(systemName: "checkmark.circle.fill")
            cell.checkImage.tintColor = UIColor(red: 0.592, green: 0.592, blue: 0.592, alpha: 1)
            return cell
        } else if collectionView == petsCollectionView {
            if indexPath.row == 0 {
                let cell = petsCollectionView.dequeueReusableCell(withReuseIdentifier: "AddNewPetCollectionViewCell", for: indexPath) as? AddNewPetCollectionViewCell
                return cell ?? UICollectionViewCell()
            } else {
                let cell = petsCollectionView.dequeueReusableCell(withReuseIdentifier: "PetsOnFeedCollectionViewCell", for: indexPath) as? PetsOnFeedCollectionViewCell
                let infoStruct = modelInstance.getPetsCollectionViewData(petNumber: indexPath.row - 1)
                cell?.petImage.image = infoStruct.petImage ?? UIImage()
                cell?.petName.text = infoStruct.petName?.capitalized

                cell?.petTaskQuantity.text = String(infoStruct.tasksQuantity ?? 0) + " " +  "tasks".localized().capitalized
                return cell ?? UICollectionViewCell()
            }
            
        }
        return UICollectionViewCell()
    }

}
extension FeedViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == petsCollectionView {
            if indexPath.row == 0 {
                let storyboard = UIStoryboard(name: "NewPet", bundle: nil)
                let newVC = storyboard.instantiateViewController(withIdentifier: "NewPetNavigationControllerViewController")
                present(newVC, animated: true, completion: nil)
            } else {
                let storyboard = UIStoryboard(name: "PetDetails", bundle: nil)

                guard let navController = storyboard.instantiateInitialViewController() as? UINavigationController, let VCdetails = navController.topViewController as? PetDetailsViewController else{ return }
                let petDataAndPet = modelInstance.getPetsInfosForPetDetails(forRowAt: indexPath.row - 1)
                VCdetails.petData = petDataAndPet.0
                VCdetails.chosenPet = petDataAndPet.1
                
                present(navController, animated: true, completion: nil)

            }
        }
    }

}
extension FeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let squareSide: CGFloat = UIScreen.main.bounds.height * 155 / 844 - 2
        let squareSide: CGFloat = ( collectionView.frame.height - 14 ) / 2
        return CGSize(width: squareSide, height: squareSide)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }
}
extension String {
    func localized() -> String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
