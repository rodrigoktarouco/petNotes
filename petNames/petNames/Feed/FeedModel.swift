//
//  FeedModel.swift
//  petNames
//
//  Created by Rodrigo Kroef Tarouco on 14/10/21.
//

import Foundation
import UIKit

enum TaskTypes {
case water
case feeding
case wash
case playtime
case walk
case groom
case medicine
case vet
case custom
}
class FeedModel {

    lazy var petArray = getAllPets()

    var task1: Task = {
        var task = Task()
        task.name = "water"
        return task
    }()
    var task2: Task = {

         var task = Task()
         task.name = "walk"
         return task
    }()
    lazy var mockTasks: [Task] = [
        task1,
        task2
    ]
    lazy var petsArray: [Pet] = {
        var petArray: [Pet] = []
        PersistanceManager.shared.listPets { result in
            switch result {
            case .success(let pets):
                petArray =  pets
            default:
                petArray = []
            }
        }
        return petArray
    }()
    
    func getTaskColor ( _ taskType: TaskTypes) -> UIColor {
        switch taskType {
        case .water :
            return UIColor(red: 0.898, green: 1, blue: 1, alpha: 1)
        case .feeding :
            return UIColor(red: 1, green: 0.947, blue: 0.898, alpha: 1)
        case .wash :
            return UIColor(red: 0.937, green: 0.898, blue: 1, alpha: 1)
        case .playtime :
            return UIColor(red: 1, green: 0.898, blue: 0.996, alpha: 1)
        case .walk :
            return UIColor(red: 0.898, green: 1, blue: 0.908, alpha: 1)
        case .medicine :
            return UIColor(red: 1, green: 0.898, blue: 0.898, alpha: 1)
        case .groom :
            return UIColor(red: 1, green: 0.978, blue: 0.898, alpha: 1)
        case .vet :
            return UIColor(red: 0.922, green: 0.922, blue: 0.922, alpha: 1)
        case .custom :
            return UIColor(red: 0.898, green: 0.949, blue: 1, alpha: 1)
        default:
            return UIColor(red: 0.898, green: 0.949, blue: 1, alpha: 1)
            
        }
    }
    func getTaskFeedCollectionViewCellData(taskNumber: Int) -> TaskFeedCollectionViewCellData {
        let taskDataStruct = TaskFeedCollectionViewCellData(petImage: UIImage(named: "pitty"), taskType: .water, taskName: "water", taskTime: "12:00", done: true)
        return taskDataStruct
    }
    func getPetsCollectionViewData( petNumber: Int) -> PetsCollectionViewDataOnFeed {
        print("HAHAHAH")
        print(petArray.count)
        let petsDataStruct = PetsCollectionViewDataOnFeed(petImage: UIImage(named: "pitty"), petName: "pitty", tasksQuantity: 3)
        return petsDataStruct
    }
    func getFractionOfNumberOfTasksDone() -> String {
        return "7 / 10"
    }
    func getUsersName() -> String {
        return PersistanceManager.shared.currentUser?.name?.capitalized ?? " "
    }
    func getNumberOfTotalTasks() -> Int {
        return 2
    }
    func getNumberOfPets() -> Int {
        return 2
    }
    func getImageForFunTasksImageView() -> UIImage? {
        let image = UIImage(named: "mockFunImage")

        return image
    }
    func getPetsInfosForPetDetails( forRowAt: Int) -> PetsInfosForPetDetails {
        //petsArray[forRowAt]

        return PetsInfosForPetDetails(name: "pitty", petImage: UIImage(named: "pitty"),petClassification: "Cachorro",petTaskNames: ["water","food","Trick Playing"])

    }

    func getAllPets() -> [Pet] {
        var petsReceive: [Pet] = []
        PersistanceManager.shared.listPets { result in
                        switch result {
                        case .success(let pets):
                            petsReceive = pets
                        case .failure(let error):
                            print(error)
                        }
        }
        return petsReceive
    }
}
struct TaskFeedCollectionViewCellData {
    var petImage: UIImage?
    var taskType: TaskTypes?
    var taskName: String?
    var taskTime: String?
    var done: Bool?
}
struct PetsCollectionViewDataOnFeed {
    var petImage: UIImage?
    var petName: String?
    var tasksQuantity: Int?
}
