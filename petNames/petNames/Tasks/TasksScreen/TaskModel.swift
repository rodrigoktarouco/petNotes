//
//  TaskModel.swift
//  petNames
//
//  Created by Rodrigo Kroef Tarouco on 14/10/21.
//

import Foundation
import UIKit

class TaskModel {
    init() {TaskManager.shared.load()}

    var cellForAllSegment: [CellInfosStruct] = []

    func getNumberOfTasks(_ selectedSegment: SelectedSegmentInTasks) -> Int {

        switch selectedSegment {
        case .all:
            return generateAllTasks()
        case .notDone:
            return generateAllTasks()
        case .byPet:
            return generateAllTasks()
        case .filter:
            return 0
        }

        return 0
    }

    func generateAllTasks() -> Int {
        cellForAllSegment = []

        for notPersistentPet in TaskManager.shared.petNotInPersistenceArray {
            for notPersistentTask in notPersistentPet.tasks {
                for notPersistentExecution in notPersistentTask.executions {
                    let nameForCell = notPersistentTask.name ?? "unnamedTask"
                    var thisImage: UIImage?  = nil
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

                    guard let date = notPersistentExecution.timeStamp else {

                        continue
                    }

                    var alert = ""
                    let formatter = DateFormatter()
                    formatter.dateStyle = .none
                    formatter.timeStyle = .short
                    formatter.timeZone = .autoupdatingCurrent
                    alert = formatter.string(from: date)

                    // MARK: Old date value
//                    var alert = ""
//                    var calendar = Calendar.autoupdatingCurrent
//                    let components = calendar.dateComponents([.hour, .minute], from: date)
//                    alert = "\(components.hour ?? 0):\(components.minute ?? 0) "

                    let  newCellInfo = CellInfosStruct(taskName: nameForCell , taskTime: alert , taskPetName: notPersistentPet.name ?? "unamedPet", taskPetImage: thisImage!, isCheckedAsDone: didTheTask, taskInPersistance: notPersistentTask.task, dateForThisExecution: date)
                    cellForAllSegment.append(newCellInfo)

                }
            }

        }

        return cellForAllSegment.count
    }
}

enum SelectedSegmentInTasks {
    case all
    case notDone
    case byPet
    case filter
}

struct CellInfosStruct {
    var taskName: String
    var taskTime: String
    let formatter = DateFormatter()
    var taskPetName: String
    var taskPetImage: UIImage
    var isCheckedAsDone: Bool
    var taskInPersistance: Task?
    var dateForThisExecution: Date?
}
