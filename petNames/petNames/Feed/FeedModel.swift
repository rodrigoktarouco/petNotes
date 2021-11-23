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

    init() {
        TaskManager.shared.load()
    }

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
                if image != nil {
                emptyDic[thisPet] = image
                } else {
                    var imageString = thisPet.image
                    if imageString == "profile-amarelo-rounded" {
                        imageString = "profile-amarelo"

                    } else if imageString == "profile-azul-rounded" {
                        imageString = "profile-azul"

                    } else if imageString == "profile-laranja-rounded" {
                        imageString = "profile-laranja"

                    } else if imageString == "profile-roxo-rounded" {
                        imageString = "profile-roxo"

                    } else if imageString == "profile-verde-rounded" {
                        imageString = "profile-verde"

                    } else {
                        imageString = "profile-vermelho"
                    }

                    emptyDic[thisPet] = UIImage(named: imageString ?? "profile-verde")
                }
            }
        }
        return emptyDic
    }()

    func getPetsCollectionViewData( petNumber: Int) -> PetsCollectionViewDataOnFeed {
        let thisPet = petsArray[petNumber]
        let petsDataStruct = PetsCollectionViewDataOnFeed(petImage: petsImages[thisPet] ?? UIImage(named: ""), petName: thisPet.name, tasksQuantity: petsTasks[thisPet]?.count ?? 0)
        return petsDataStruct
    }

    func getFractionOfNumberOfTasksDone() -> String {
        guard let tuple = TaskManager.shared.allPetsFractionOfDoneTasksAsTuple as? (Int,Int) else{
            return " 0\0 "
        }
        let numerador = tuple.0
        let denominador = tuple.1

        let fraction = "\(numerador) / \(denominador)"

        return fraction
    }

    func getUsersName() -> String {
        return PersistanceManager.shared.currentUser?.name?.capitalized ?? " "
    }
    func getTaskFeedCollectionViewCellData(taskNumber: Int) -> TaskFeedCollectionViewCellData { // send the task name as it is on the persistence
        var thisPetImage = UIImage(named: "pitty")
        let thisNotInPersistenceExecution = TaskManager.shared.arrayOfCalculatedExecutionsNotDone[taskNumber]
        if let pet = thisNotInPersistenceExecution.taskNotInPersistence?.thisPetNotInPersistence?.pet{
            PersistanceManager.shared.getPetImage(pet) { image in
                if image != nil {
                    thisPetImage = image
                } else {
                    thisPetImage = UIImage(named: pet.image ?? "")
                }
            }
        }
        let nameOfTask = thisNotInPersistenceExecution.taskNotInPersistence?.name
        guard let date = thisNotInPersistenceExecution.timeStamp else {
            let taskDataStruct = TaskFeedCollectionViewCellData(petImage: thisPetImage, taskName: nameOfTask, taskTime: "--:--", done: false)
            return taskDataStruct
        }
        var alert = ""
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        formatter.timeZone = .autoupdatingCurrent
        alert = formatter.string(from: date)

        //MARK: Old Formatter
//        var calendar = Calendar.autoupdatingCurrent
//        let components = calendar.dateComponents([.hour, .minute], from: date)
//        let hour = components.hour ?? 0
//        let hourString = hour < 10 ? "0\(hour)" : "\(hour)"
//        let minutes = components.minute ?? 0
//        let minutesString = minutes < 10 ? "0\(minutes)" : "\(minutes)"
//        alert = "\(hourString):\(minutesString)"

        let taskDataStruct = TaskFeedCollectionViewCellData(petImage: thisPetImage, taskName: nameOfTask, taskTime: alert, done: false)
        return taskDataStruct
    }

    func getNumberOfTotalTasks() -> Int {

        return TaskManager.shared.arrayOfCalculatedExecutionsNotDone.count
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

    var taskName: String?
    var taskTime: String?
    var done: Bool?
}
struct PetsCollectionViewDataOnFeed {
    var petImage: UIImage?
    var petName: String?
    var tasksQuantity: Int?
}
