//
//  FeedModel.swift
//  petNames
//
//  Created by Rodrigo Kroef Tarouco on 14/10/21.
//

import Foundation
import UIKit
import AVFoundation

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

    let imageNamesPerWeekDay: [String: String] = [
        "Sunday": "banner-domingo",
        "Monday": "banner-segunda",
        "Tuesday": "banner-terca",
        "Wednesday": "banner-quarta",
        "Thursday": "banner-quinta",
        "Friday": "banner-sexta",
        "Saturday": "banner-sabado"
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

    lazy var petsTasks: [Pet: [Task]] = {
        var emptyDic: [Pet: [Task]] = [:]
        for thisPet in petsArray {
            PersistanceManager.shared.listTasksFromPet(pet: thisPet) { result in
                switch result {
                case .success(let tasksFromPersistence):
                    emptyDic[thisPet] = tasksFromPersistence
                case .failure(let error):
                    emptyDic[thisPet] = []
                }
            }
        }
        return emptyDic
    }()

    lazy var petsImages: [Pet: UIImage?] = {
        var emptyDic: [Pet: UIImage?] = [:]
        for thisPet in petsArray {
            PersistanceManager.shared.getPetImage(thisPet) { image in
                emptyDic[thisPet] = image
            }
        }
        return emptyDic
    }()

    func getTaskFeedCollectionViewCellData(taskNumber: Int) -> TaskFeedCollectionViewCellData { // send the task name as it is on the persistence

        let taskDataStruct = TaskFeedCollectionViewCellData(petImage: UIImage(named: "pitty"), taskType: .water, taskName: "water", taskTime: "12:00", done: true)
        return taskDataStruct
    }

    func getPetsCollectionViewData( petNumber: Int) -> PetsCollectionViewDataOnFeed {
        let thisPet = petsArray[petNumber]
        let petsDataStruct = PetsCollectionViewDataOnFeed(petImage: petsImages[thisPet] ?? UIImage(named: ""), petName: thisPet.name, tasksQuantity: petsTasks[thisPet]?.count ?? 0)
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
        return petsArray.count
    }
    func getDayOfWeek() -> String? {

        let dateInstance = Date()

        let weekDays = [
            "Sunday",
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Saturday"
        ]

        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date: String = formatter.string(from: dateInstance)
        guard let myDate = formatter.date(from: date) else { return nil }

        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: myDate)

        return weekDays[weekDay-1]
    }
    func getImageForFunTasksImageView() -> UIImage? {
        let dayOfWeek = getDayOfWeek() ?? "Sunday"
        let image = UIImage(named: imageNamesPerWeekDay[dayOfWeek] ?? "banner-domingo")
        return image
    }

    func getPetsInfosForPetDetails( forRowAt: Int) -> (PetsInfosForPetDetails, Pet) {
        let thisPet = petsArray[forRowAt]
        var taskNames: [String] = []
        let theseTasks = petsTasks[thisPet]!
        for thisTask in theseTasks {
            guard let thisName = thisTask.name else {continue}
            taskNames.append(thisName)
        }

        return (PetsInfosForPetDetails(name: thisPet.name ?? "unnamedAnimal", petImage: petsImages[thisPet] ?? UIImage(named: ""), petClassification: thisPet.category, petTaskNames: taskNames) , thisPet)

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
