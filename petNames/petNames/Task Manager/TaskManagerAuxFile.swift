//
//  TaskManagerAuxFile.swift
//  petNames
//
//  Created by Heitor Feijó Kunrath on 24/11/21.
//

import Foundation

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
    var fractionOfDoneTasksAsTuple: (Int, Int)?

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

enum TodayOrTomorrowEnum {
    case today
    case tomorrow
}
