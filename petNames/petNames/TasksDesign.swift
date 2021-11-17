//
//  TasksDesign.swift
//  petNames
//
//  Created by Heitor Feijó Kunrath on 04/11/21.
//

import Foundation
import UIKit

//  ["Water", "Food", "Wash", "Playtime", "Walk", "Medicine", "Groom", "Vet", "Custom"]

class TasksDesign {
    init() {}
    static var shared: TasksDesign = TasksDesign()
    var tasksDesignPropertiesArray: [TasksDesignProperties] = {
        let water = TasksDesignProperties(name: "water", taskImage: UIImage(named: "water-task-icon"), color: UIColor(named: "TC-water-inside"))
        let food = TasksDesignProperties(name: "food", taskImage: UIImage(named: "food-task-icon"), color: UIColor(named: "TC-food-inside"))
        let wash = TasksDesignProperties(name: "wash", taskImage: UIImage(named: "wash-task-icon"), color: UIColor(named: "TC-wash-inside"))
        let playtime = TasksDesignProperties(name: "playtime", taskImage: UIImage(named: "playtime-task-icon"), color: UIColor(named: "TC-playtime-inside"))
        let walk  = TasksDesignProperties(name: "walk", taskImage: UIImage(named: "walk-task-icon"), color: UIColor(named: "TC-walk-inside"))
        let medicine = TasksDesignProperties(name: "medicine", taskImage: UIImage(named: "medicine-task-icon"), color: UIColor(named: "TC-medicine-inside"))
        let groom = TasksDesignProperties(name: "groom", taskImage: UIImage(named: "groom-task-icon"), color: UIColor(named: "TC-groom-inside"))
        let vet = TasksDesignProperties(name: "vet", taskImage: UIImage(named: "vet-task-icon"), color: UIColor(named: "TC-vet-inside"))
        let custom = TasksDesignProperties(name: "custom", taskImage: UIImage(named: "custom-task-icon"), color: UIColor(named: "TC-custom-inside"))

       return [ water, food, wash, playtime, walk, medicine, groom, vet, custom]
    }()

    func getTaskDesignProperties( _ taskName: String) -> TasksDesignProperties {
        for task in tasksDesignPropertiesArray {
            if task.name.lowercased() == taskName.lowercased() {
                return task
            }
        }
        return tasksDesignPropertiesArray.last ?? TasksDesignProperties(name: "custom", taskImage: UIImage(named: "custom-task-icon"), color: UIColor(red: 0.922, green: 0.922, blue: 0.922, alpha: 1)) // the last is the custom TasksDesignProperties
    }

    var tasksCellBorder: [TasksCellBorder] = {
        let water = TasksCellBorder(name: "water", color: UIColor(named: "TC-water-border") ?? .red)
        let food = TasksCellBorder(name: "food", color: UIColor(named: "TC-food-border") ?? .red)
        let wash = TasksCellBorder(name: "wash", color: UIColor(named: "TC-wash-border") ?? .red)
        let playtime = TasksCellBorder(name: "playtime", color: UIColor(named: "TC-playtime-border") ?? .red)
        let walk = TasksCellBorder(name: "walk", color: UIColor(named: "TC-walk-border") ?? .red)
        let medicine = TasksCellBorder(name: "medicine", color: UIColor(named: "TC-medicine-border") ?? .red)
        let groom = TasksCellBorder(name: "groom", color: UIColor(named: "TC-groom-border") ?? .red)
        let vet = TasksCellBorder(name: "vet", color: UIColor(named: "TC-vet-border") ?? .red)
        let custom = TasksCellBorder(name: "custom", color: UIColor(named: "TC-custom-border") ?? .red)

        return [water, food, wash, playtime, walk, medicine, groom, vet, custom]
    }()

    func getTasksCellBorder( _ taskName: String) -> TasksCellBorder {
        for task in tasksCellBorder {
            if task.name.lowercased() == taskName.lowercased() {
                return task
            }
        }
        return tasksCellBorder.last ?? TasksCellBorder(name: "custom", color: UIColor(named: "TC-custom-border") ?? .red) // the last is the custom TasksCellBorder
    }

    func pickTaskIcon(task: String) -> String {
        var iconAsset: String

        switch task {
        case "Water".localized():
            iconAsset = "water-task-icon"
        case "Food".localized():
            iconAsset = "food-task-icon"
        case "Wash".localized():
            iconAsset = "wash-task-icon"
        case "Playtime".localized():
            iconAsset = "playtime-task-icon"
        case "Walk".localized():
            iconAsset = "walk-task-icon"
        case "Medicine".localized():
            iconAsset = "medicine-task-icon"
        case "Groom".localized():
            iconAsset = "groom-task-icon"
        case "Vet".localized():
            iconAsset = "vet-task-icon"
        case "Custom".localized():
            iconAsset = "custom-task-icon"
        default:
            iconAsset = "custom-task-icon"
        }

        return iconAsset
    }
}

struct TasksDesignProperties {
    var name: String
    var taskImage: UIImage?
    var color: UIColor?
}

struct TasksCellBorder {
    var name: String
    var color: UIColor
}

struct TasksCheckMark {
    var name: String
    var color: UIColor
}
