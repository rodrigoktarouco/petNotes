//
//  TasksManager.swift
//  petNames
//
//  Created by Heitor Feijó Kunrath on 10/11/21.
//

import Foundation

class TaskManager {

    private init() { }

    static let shared: TaskManager = TaskManager()

    var PetNotInPersistenceArray: [PetNotInPersistence] = []
    var allPetsFractionOfDoneTasksAsTuple: (Int,Int)?
    var arrayOfCalculatedExecutionsNotDone: [ExecutionNotInPersistence] = []

    func load() {
        setPetsAndSupposedToExistExecutions()
        TasksFromNowOnToBeDone()
        _ = getNumberOfTasksNotDoneAndDone()

        //printAll()
    }

    func TasksFromNowOnToBeDone() {
        arrayOfCalculatedExecutionsNotDone = []
        let currentDate = Date()

        for pet in PetNotInPersistenceArray {
            for task in pet.tasks {
                task.executionsCalculatedAfterCurrentTime = []

                for thisExecution in  task.executionsThatDoNotExist {

                    guard let executionDate = thisExecution.timeStamp  else {
                        return
                    }

                    if currentDate < executionDate {
                        task.executionsCalculatedAfterCurrentTime.append(thisExecution)
                        arrayOfCalculatedExecutionsNotDone.append(thisExecution)
                    }
                }
            }
        }
    }

    func getNumberOfTasksNotDoneAndDone() -> (Int,Int) {
        var notDone: Int = 0// for all pets
        var done: Int = 0// for all pets
        for pet in PetNotInPersistenceArray {
            var thisPetNotDone: Int = 0
            var thisPetDone: Int = 0
            for task in pet.tasks {
                done += task.executionsThatDoExist.count
                notDone += task.executionsThatDoNotExist.count

                thisPetDone += task.executionsThatDoExist.count
                thisPetNotDone += task.executionsThatDoNotExist.count

            }
            pet.fractionOfDoneTasksAsTuple = (thisPetDone,thisPetNotDone)
        }
        allPetsFractionOfDoneTasksAsTuple =  (done,notDone)
        return (done,notDone)
    }

    //func setUpPetsAndExistingExecutions() {
//        var allPets: [Pet] = []
//        PersistanceManager.shared.listPets { result in
//            switch result {
//            case .success(let pets):
//                allPets = pets
//            default:
//                break
//            }
//        }
//    }

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
            let newPetNotInPersistence = PetNotInPersistence()
            newPetNotInPersistence.pet = pet
            newPetNotInPersistence.id = pet.id
            newPetNotInPersistence.name = pet.name
            PetNotInPersistenceArray.append(newPetNotInPersistence) // populating PetNotInPersistenceArray with pets

            let thisPetTasks = (pet.tasks ?? []).compactMap { $0 as? Task }

            for thisTask in thisPetTasks {
                var newTaskNotInPersistence = TaskNotInPersistence()
                let thisTasksSuposedToExistExecutions = executionGenerator(thisTask: thisTask, thisTaskNotInPersistence: &newTaskNotInPersistence)
                newTaskNotInPersistence.task = thisTask
                newTaskNotInPersistence.executions = thisTasksSuposedToExistExecutions
                newTaskNotInPersistence.id = thisTask.id
                newTaskNotInPersistence.name = thisTask.name
                newTaskNotInPersistence.thisPetNotInPersistence = newPetNotInPersistence
                newPetNotInPersistence.tasks.append(newTaskNotInPersistence) // populating newPetNotInPersistence with tasks

                let executionsFromPersistence = (thisTask.executions ?? []).compactMap { $0 as? Execution }
                for realExecution in executionsFromPersistence {
                    for fakeExecution in newTaskNotInPersistence.executions {
                        if realExecution.timeStamp == fakeExecution.timeStamp {// if the fake execution exists
                            fakeExecution.execution = realExecution
                            newTaskNotInPersistence.executionsThatDoExist.append(fakeExecution) // now we know which executions DO exist and did that by populating the "executionsThatDoExist" inside each TaskNotInPersistence
                            break
                        }
                    }
                }



            }
        }


        for pet in PetNotInPersistenceArray { // now we must populate the "executionsThatDoNotExist"
            for task in pet.tasks {
                for thisExecution in task.executions {
                    if thisExecution.execution == nil {
                        task.executionsThatDoNotExist.append(thisExecution)
                    }
                }
            }
        }
    }

    func executionGenerator(thisTask: Task, thisTaskNotInPersistence: inout TaskNotInPersistence) -> [ExecutionNotInPersistence] {
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
                    newExecution.taskNotInPersistence = thisTaskNotInPersistence
                    //print(thisExecutionsTime)
                    executions.append(newExecution)
                }
            }
        case .never:
            return []

        }
        return executions
    }
    func printAll() {
        print("#######", Date(),"#######")
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
    var fractionOfDoneTasksAsTuple: (Int,Int)?


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
    weak var thisPetNotInPersistence: PetNotInPersistence?
    var executions: [ExecutionNotInPersistence] = []
    var executionsThatDoExist: [ExecutionNotInPersistence] = []
    var executionsThatDoNotExist: [ExecutionNotInPersistence] = []
    var executionsCalculatedAfterCurrentTime: [ExecutionNotInPersistence] = []

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
    weak var taskNotInPersistence: TaskNotInPersistence?

}


