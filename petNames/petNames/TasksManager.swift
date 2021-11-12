//
//  TasksManager.swift
//  petNames
//
//  Created by Heitor Feijó Kunrath on 10/11/21.
//

import Foundation

class TaskManager {

    private init() {}

    let shared: TaskManager = TaskManager()

    var petsAndSupposedToExistExecutions: [Pet: [Execution]] = [: ]
    var petsAndExistingExecutions: [Pet: [Execution]] = [: ]

    func setPetsAndSupposedToExistExecutions() {
        var allPets: [Pet] = []
        PersistanceManager.shared.listPets { result in
            switch result {
            case .success(let pets):
                allPets = pets
            default:
                break
            }
        }
        for pet in allPets {
            let thisPetTasks = (pet.tasks ?? []).compactMap { $0 as? Task }
            for thisTask in thisPetTasks {
                let thisTasksSuposedToExistExecutions = executionGenerator(thisTask: thisTask)
                petsAndSupposedToExistExecutions[pet] = thisTasksSuposedToExistExecutions
            }
        }
    }

    func executionGenerator(thisTask: Task) -> [Execution] {
        let date = String(DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .short)).components(separatedBy: " ")
        let day = date[0]
        let time = date[1]
        let repetition = thisTask.taskRepetition

        return []
    }
}
