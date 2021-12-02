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

    var petNotInPersistenceArray: [PetNotInPersistence] = []
    var allPetsFractionOfDoneTasksAsTuple: (Int, Int)?
    var arrayOfCalculatedExecutionsNotDone: [ExecutionNotInPersistence] = []

    func load() {

        setPetsAndSupposedToExistExecutions()
        tasksFromNowOnToBeDone()
        _ = getNumberOfTasksNotDoneAndDone()

        // printAll()
    }

    func tasksFromNowOnToBeDone() {
        arrayOfCalculatedExecutionsNotDone = []

        guard let todaysBeginning = Calendar.current.date(bySettingHour: 0,
                                                          minute: 0,
                                                          second: 0,
                                                          of: Date()),
              let todaysMidnight = Calendar.current.date(byAdding: .day,
                                                   value: 1,
                                                   to: todaysBeginning) else { return }

        for pet in petNotInPersistenceArray {
            for task in pet.tasks {
                task.executionsCalculatedAfterCurrentTime = []

                for thisExecution in  task.executionsThatDoNotExist {

                    guard let executionDate = thisExecution.timeStamp  else {
                        return
                    }

                    if todaysBeginning < executionDate && executionDate < todaysMidnight {
                        task.executionsCalculatedAfterCurrentTime.append(thisExecution)
                        arrayOfCalculatedExecutionsNotDone.append(thisExecution)
                    }
                }
            }
        }
    }

    func getNumberOfTasksNotDoneAndDone() -> (Int, Int) {
        var notDone: Int = 0// for all pets
        var done: Int = 0// for all pets

        let todaysBeginning = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!
        guard let todaysMidnight = Calendar.current.date(byAdding: .day,
                                                         value: 1,
                                                         to: todaysBeginning) else { return (0,0) }

        for pet in petNotInPersistenceArray {
            var thisPetNotDone: Int = 0
            var thisPetDone: Int = 0
            for task in pet.tasks {
                for existingExec in task.executionsThatDoExist {
                    if todaysMidnight > existingExec.timeStamp! && existingExec.timeStamp! > todaysBeginning {
                        done += 1
                        thisPetDone += 1
                    }
                }
                for notExistingExec in task.executionsThatDoNotExist {
                    if todaysMidnight > notExistingExec.timeStamp! && notExistingExec.timeStamp! > todaysBeginning {
                        notDone += 1
                        thisPetNotDone += 1
                    }

                }

            }

            pet.fractionOfDoneTasksAsTuple = (thisPetDone, thisPetNotDone + thisPetDone)
        }
        allPetsFractionOfDoneTasksAsTuple =  (done, notDone + done)
        return (done, notDone + done)
    }

    func setPetsAndSupposedToExistExecutions() {

        petNotInPersistenceArray = []

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
            petNotInPersistenceArray.append(newPetNotInPersistence) // populating petNotInPersistenceArray with pets

            let thisPetTasks = (pet.tasks ?? []).compactMap { $0 as? Task }

            for thisTask in thisPetTasks {
                var newTaskNotInPersistence = TaskNotInPersistence()
                let thisTasksSuposedToExistExecutions = executionGenerator(thisTask: thisTask,
                                                                           thisTaskNotInPersistence: &newTaskNotInPersistence)
                newTaskNotInPersistence.task = thisTask
                newTaskNotInPersistence.executions = thisTasksSuposedToExistExecutions
                newTaskNotInPersistence.id = thisTask.id
                newTaskNotInPersistence.name = thisTask.name
                newTaskNotInPersistence.thisPetNotInPersistence = newPetNotInPersistence
                newPetNotInPersistence.tasks.append(newTaskNotInPersistence)
                // populating newPetNotInPersistence with tasks

                let executionsFromPersistence = (thisTask.executions ?? []).compactMap { $0 as? Execution }
                for realExecution in executionsFromPersistence {
                    for fakeExecution in newTaskNotInPersistence.executions {
                        if realExecution.timeStamp == fakeExecution.timeStamp {
                            // if the fake execution exists
                            fakeExecution.execution = realExecution
                            newTaskNotInPersistence.executionsThatDoExist.append(fakeExecution)
                            // now we know which executions DO exist
                            // and did that by populating the "executionsThatDoExist" inside each TaskNotInPersistence
                            break
                        }
                    }
                }

            }
        }

        for pet in petNotInPersistenceArray { // now we must populate the "executionsThatDoNotExist"
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

                    let thisExecutionsTime = utcCalendar.date(bySettingHour: thisHour,
                                                              minute: thisMinute,
                                                              second: 0, of: day)!
                    let newExecution = ExecutionNotInPersistence()
                    newExecution.timeStamp = thisExecutionsTime
                    newExecution.taskNotInPersistence = thisTaskNotInPersistence
                    executions.append(newExecution)
                }
            }
        case .never:
            let now = Date()
            //let todayCalendar = Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: now)!
            let currentTime = now.description.components(separatedBy: [" "])[1]
            let currentTimeInPartsAsString = currentTime.components(separatedBy: [":"])
            let currentTimeInPartsAsInt = currentTimeInPartsAsString.map { str -> Int in
                if let myInt = Int(str) {
                    return myInt
                } else {
                    return Int.max
                }
            }
            var todayOrTomorrow: TodayOrTomorrowEnum = .today
            for alertTime in thisTask.alertTimes {
                guard let thisHour = alertTime.hour, let thisMinute = alertTime.minute else {
                    continue
                }

                if currentTimeInPartsAsInt[0] > thisHour {
                    todayOrTomorrow = .tomorrow
                } else {
                    if currentTimeInPartsAsInt[1] > thisMinute {
                        todayOrTomorrow = .tomorrow
                    } else {
                        todayOrTomorrow = .today
                    }
                }
                switch todayOrTomorrow {
                case .today:
                    var utcCalendar = Calendar.current
                    utcCalendar.timeZone = TimeZone(identifier: "UTC") ?? .autoupdatingCurrent
                    let thisExecutionsTime = utcCalendar.date(bySettingHour: thisHour,
                                                              minute: thisMinute,
                                                              second: 0, of: Date())!
                    let newExecution = ExecutionNotInPersistence()
                    newExecution.timeStamp = thisExecutionsTime
                    newExecution.taskNotInPersistence = thisTaskNotInPersistence
                    executions.append(newExecution)

                case .tomorrow:
                    var utcCalendar = Calendar.current
                    utcCalendar.timeZone = TimeZone(identifier: "UTC") ?? .autoupdatingCurrent
                    let thisExecutionsTime = utcCalendar.date(bySettingHour: thisHour,
                                                              minute: thisMinute,
                                                              second: 0, of: Date.tomorrow)!
                    let newExecution = ExecutionNotInPersistence()
                    newExecution.timeStamp = thisExecutionsTime
                    newExecution.taskNotInPersistence = thisTaskNotInPersistence
                    executions.append(newExecution)
                }
            }

        }
        return executions
    }

    func printAll() {
        for pet in petNotInPersistenceArray {
            print("nome: ", String(describing: pet.name))
            for task in pet.tasks {
                print(String(describing: task.name))
                // print(task.task?.observations)
                // print(task.task?.alerts)
                for exec in task.executions {
                    print(String(describing: exec.timeStamp))
                    print("-")
                }
                print("--")
            }
            print("---")
        }
    }

}
