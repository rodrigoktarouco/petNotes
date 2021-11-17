//
//  TasksManager.swift
//  petNames
//
//  Created by Heitor Feijó Kunrath on 10/11/21.
//

import Foundation

class TaskManager {

    private init() {}

    static let shared: TaskManager = TaskManager()

    var petsAndSupposedToExistExecutions: [PetNotInPersistence: [TaskNotInPersistence: [ExecutionNotInPersistence]]] = [:]
    var petsAndExistingExecutions: [PetNotInPersistence: [TaskNotInPersistence: [ExecutionNotInPersistence]]] = [:]
    var PetNotInPersistenceArray: [PetNotInPersistence] = []


    func load() {
        setPetsAndSupposedToExistExecutions()
        setPetsAndSupposedToExistExecutions()
        //printAll()
        }

    func setUpPetsAndExistingExecutions() {
        var allPets: [Pet] = []
        PersistanceManager.shared.listPets { result in
            switch result {
            case .success(let pets):
                allPets = pets
            default:
                break
            }
        }




    }

    func setPetsAndSupposedToExistExecutions() {
        var allPets: [Pet] = []
        PersistanceManager.shared.listPets { result in
            switch result {
            case .success(let pets):
                allPets = pets
            default:
                break
            }
            for pet in self.PetNotInPersistenceArray {
                for task in pet.tasks {
                    let executionsFromPersistence = (task.task?.executions ?? []).compactMap { $0 as? Execution }
                    for realExecution in executionsFromPersistence {
                        for fakeExecution in task.executions {
                            if realExecution.timeStamp == fakeExecution.timeStamp {// if the fake execution exists
                                fakeExecution.execution = realExecution
                                task.executionsThatDoExist.append(fakeExecution)
                                break
                            }
                        }
                    }
                }
            } // now we know which executions DO exist and did that by populating the "executionsThatDoExist" inside each TaskNotInPersistence
            // now we must populate the "executionsThatDoNotExist"
            for pet in self.PetNotInPersistenceArray {
                for task in pet.tasks {
                    for thisExecution in task.executions {
                        if thisExecution.execution == nil {
                            task.executionsThatDoNotExist.append(thisExecution)
                        }
                    }
                }
            }

        }

        for pet in allPets {
            let newPetNotInPersistence = PetNotInPersistence()
            newPetNotInPersistence.pet = pet
            newPetNotInPersistence.id = pet.id
            newPetNotInPersistence.name = pet.name
            PetNotInPersistenceArray.append(newPetNotInPersistence)

            let thisPetTasks = (pet.tasks ?? []).compactMap { $0 as? Task }
            petsAndSupposedToExistExecutions[newPetNotInPersistence] = [:]

            for thisTask in thisPetTasks {
                let thisTasksSuposedToExistExecutions = executionGenerator(thisTask: thisTask)

                let newTaskNotInPersistence = TaskNotInPersistence()
                newTaskNotInPersistence.task = thisTask
                newTaskNotInPersistence.executions = thisTasksSuposedToExistExecutions
                newTaskNotInPersistence.id = thisTask.id
                newTaskNotInPersistence.name = thisTask.name
                newPetNotInPersistence.tasks.append(newTaskNotInPersistence)

                petsAndSupposedToExistExecutions[newPetNotInPersistence]![newTaskNotInPersistence] =  thisTasksSuposedToExistExecutions // can force it because of the petsAndSupposedToExistExecutions[newPetAux] = [:] before the loop
            }
        }
    }

    func executionGenerator(thisTask: Task) -> [ExecutionNotInPersistence] {
//        let date = String(DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .short)).components(separatedBy: " ")
//        let day = date[0]
//        let time = date[1]
        let repetition = thisTask.taskRepetition
        var executions: [ExecutionNotInPersistence] = []
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
                    var utcCalendar = Calendar.current
                    utcCalendar.timeZone = TimeZone(identifier: "UTC") ?? .autoupdatingCurrent

                    //let finalDate = utcCalendar.date(bySettingHour: components.hour!, minute: components.minute!, second: 0, of: day)!
                    let thisExecutionsTime = utcCalendar.date(bySettingHour: thisHour, minute: thisMinute, second: 0, of: day)!
                    var newExecution = ExecutionNotInPersistence ()
                    newExecution.timeStamp = thisExecutionsTime
                    print(thisExecutionsTime)
                    executions.append(newExecution)
                }
            }
        case .never:
            return []

        }
        return executions
    }
    func printAll() {
        for pet in PetNotInPersistenceArray {
            print("nome: ",pet.name)
            for task in pet.tasks {
                print(task.name)
                //print(task.task?.observations)
                //print(task.task?.alerts)
                for exec in task.executions {
                    print(exec.timeStamp)
                    print("-")
                }
                print("--")
            }
            print("---")
        }
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
class PetNotInPersistence: Hashable {

    var id: String?
    var name: String?
    var pet: Pet?
    var tasks: [TaskNotInPersistence] = []

    static func == (lhs: PetNotInPersistence, rhs: PetNotInPersistence) -> Bool {
        if let lhsID = lhs.id, let rhsID = rhs.id {
            return lhsID.compare(rhsID, options: .caseInsensitive) == .orderedSame
        }
        if let lhsName = lhs.name, let rhsName = rhs.name {
            return lhsName.compare(rhsName, options: .caseInsensitive) == .orderedSame
        }

        return false
    }

    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(name)
        }
}

class TaskNotInPersistence: Hashable {

    var id: String?
    var name: String?
    var task: Task?
    var executions: [ExecutionNotInPersistence] = []
    var executionsThatDoExist: [ExecutionNotInPersistence] = []
    var executionsThatDoNotExist: [ExecutionNotInPersistence] = []

    static func == (lhs: TaskNotInPersistence, rhs: TaskNotInPersistence) -> Bool {
        if let lhsID = lhs.id, let rhsID = rhs.id {
            return lhsID.compare(rhsID, options: .caseInsensitive) == .orderedSame
        }
        if let lhsName = lhs.name, let rhsName = rhs.name {
            return lhsName.compare(rhsName, options: .caseInsensitive) == .orderedSame
        }

        return false
    }
    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(name)
        }

}

class ExecutionNotInPersistence {
    var timeStamp: Date?
    var execution: Execution?// if not nil, then it exists and has been performed in the real world
}


