//
//  TaskModel.swift
//  petNames
//
//  Created by Rodrigo Kroef Tarouco on 14/10/21.
//

import Foundation
import UIKit

class TaskModel {

    init() { TaskManager.shared.load() }

    var cellForAllSegment: [CellInfosStruct] = []
    var cellForNotDoneSegment: [CellInfosStruct] = []
    var cellForPetSegment: [CellInfosStruct] = []

    func getNumberOfTasks(_ selectedSegment: SelectedSegmentInTasks) -> Int {

        switch selectedSegment {
        case .all:
            return generateAllTasks()
        case .notDone:
            return generateNotDoneTasks()
        case .byPet:
            return generatePetTasks()
        case .filter:
            return 0
        }
    }

    func generatePetTasks() -> Int {
        cellForPetSegment = []

        for notPersistentPet in TaskManager.shared.petNotInPersistenceArray {
            for notPersistentTask in notPersistentPet.tasks {
                for notPersistentExecution in notPersistentTask.executions {

                    guard let date = notPersistentExecution.timeStamp else {
                        continue
                    }

                    if notPersistentTask.task?.deletedAlertDates.contains(date) ?? false {
                        continue
                    }

                    let nameForCell = notPersistentTask.name ?? "unnamedTask"
                    var thisImage: UIImage?
                    if let tpet = notPersistentPet.pet {
                        PersistanceManager.shared.getPetImage(tpet) { image in
                            thisImage = image
                        }
                    }
                    if thisImage == nil {
                        thisImage = UIImage(named: notPersistentPet.pet?.image ?? "")
                    }
                    var didTheTask = false
                    if notPersistentExecution.execution != nil {
                        didTheTask = true
                    }


                    var alert = ""
                    let formatter = DateFormatter()
                    formatter.dateStyle = .none
                    formatter.timeStyle = .short
                    formatter.timeZone = .autoupdatingCurrent
                    alert = "   􀐫 " + formatter.string(from: date)

                    formatter.dateFormat = "dd/MM/yyyy"

                    alert = "􀉉 " + formatter.string(from: date) + alert

                    let  newCellInfo = CellInfosStruct(taskName: nameForCell ,
                                                       taskTime: alert ,
                                                       taskPetName: notPersistentPet.name ?? "unamedPet",
                                                       taskPetImage: thisImage!,
                                                       isCheckedAsDone: didTheTask,
                                                       taskInPersistance: notPersistentTask.task,
                                                       dateForThisExecution: date)
                    cellForPetSegment.append(newCellInfo)

                }
            }

        }

        return cellForPetSegment.count
    }

    func generateAllTasks() -> Int {
        cellForAllSegment  = cellForPetSegment
        cellForAllSegment.sort {
           return  $0.dateForThisExecution ?? Date() < $1.dateForThisExecution ?? Date()
        }

        return cellForAllSegment.count

    }

    func generateNotDoneTasks() -> Int {

        cellForNotDoneSegment = []
        cellForNotDoneSegment = cellForPetSegment.filter { cell in
            return cell.isCheckedAsDone == false
        }

        return cellForNotDoneSegment.count
    }

    func reloadEveryArrayOfThisObject() {
        TaskManager.shared.load()
        _ = generatePetTasks()
        _ = generateAllTasks()
        _ = generateNotDoneTasks()
    }

}

enum SelectedSegmentInTasks {
    case all
    case notDone
    case byPet
    case filter
}

struct CellInfosStruct: Equatable {
    var taskName: String
    var taskTime: String
    let formatter = DateFormatter()
    var taskPetName: String
    var taskPetImage: UIImage
    var isCheckedAsDone: Bool
    var taskInPersistance: Task?
    var dateForThisExecution: Date?
}

extension String {
    fileprivate func subString(from: Int, to: Int) -> String {
       let startIndex = self.index(self.startIndex, offsetBy: from)
       let endIndex = self.index(self.startIndex, offsetBy: to)
       return String(self[startIndex..<endIndex])
    }
}
