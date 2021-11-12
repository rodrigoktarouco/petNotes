//
//  TasksManager.swift
//  petNames
//
//  Created by Heitor Feijó Kunrath on 10/11/21.
//

import Foundation

class TaskManager {

    private init() { }

    let shared: TaskManager = TaskManager()
    var petsAndSupposedToExistExecutions: [Pet: [Execution]] = [:]
    var petsAndExistingExecutions: [Pet: [Execution]] = [:]

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
//        let date = String(DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .short)).components(separatedBy: " ")
//        let day = date[0]
//        let time = date[1]
        let repetition = thisTask.taskRepetition
        var executions: [Execution] = []
        guard let thisTasksRepetition = repetition else {
            return []
        }
        switch thisTasksRepetition {
        case .daily:
            let today = Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: Date())!
            for day in [Date.yesterday, today, Date.tomorrow] {
                for alertTime in thisTask.alertTimes {
                    guard let thisHour = alertTime.hour, let thisMinute = alertTime.minute else {
                        continue
                    }
                    let thisExecutionsTime = Calendar.current.date(bySettingHour: thisHour, minute: thisMinute, second: 0, of: day)!
                    let newExecution = Execution()
                    newExecution.timeStamp = thisExecutionsTime
                    executions.append(newExecution)
                }
            }
        case .never:
            return []

        }

        return executions
    }

}
extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow: Date { return Date().dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month, from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
}
