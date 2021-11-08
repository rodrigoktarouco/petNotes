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
        let water = TasksDesignProperties(name: "water", taskImage: UIImage(named: "water-task-icon"), color: UIColor(red: 0.808, green: 1, blue: 1, alpha: 1))
        let food = TasksDesignProperties(name: "food", taskImage: UIImage(named: "food-task-icon"), color: UIColor(red: 1, green: 0.92, blue: 0.852, alpha: 1))
        let wash = TasksDesignProperties(name: "wash", taskImage: UIImage(named: "wash-task-icon"), color: UIColor(red: 0.902, green: 0.842, blue: 1, alpha: 1))
        let playtime = TasksDesignProperties(name: "playtime", taskImage: UIImage(named: "playtime-task-icon"), color: UIColor(red: 1, green: 0.833, blue: 0.993, alpha: 1))
        let walk  = TasksDesignProperties(name: "walk", taskImage: UIImage(named: "walk-task-icon"), color: UIColor(red: 0.843, green: 1, blue: 0.859, alpha: 1))
        let medicine = TasksDesignProperties(name: "medicine", taskImage: UIImage(named: "medicine-task-icon"), color: UIColor(red: 1, green: 0.846, blue: 0.846, alpha: 1))
        let groom = TasksDesignProperties(name: "groom", taskImage: UIImage(named: "groom-task-icon"), color: UIColor(red: 1, green: 0.961, blue: 0.829, alpha: 1))
        let vet = TasksDesignProperties(name: "vet", taskImage: UIImage(named: "vet-task-icon"), color: UIColor(red: 0.863, green: 0.929, blue: 1, alpha: 1))
        let custom = TasksDesignProperties(name: "custom", taskImage: UIImage(named: "custom-task-icon"), color: UIColor(red: 0.922, green: 0.922, blue: 0.922, alpha: 1))

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

    func pickTaskIcon(task: String) -> String {
        var iconAsset: String

        switch task {
        case "Water":
            iconAsset = "water-task-icon"
        case "Food":
            iconAsset = "food-task-icon"
        case "Wash":
            iconAsset = "wash-task-icon"
        case "Playtime":
            iconAsset = "playtime-task-icon"
        case "Walk":
            iconAsset = "walk-task-icon"
        case "Medicine":
            iconAsset = "medicine-task-icon"
        case "Groom":
            iconAsset = "groom-task-icon"
        case "Vet":
            iconAsset = "vet-task-icon"
        default:
            iconAsset = "xmark"
        }

        return iconAsset
    }
}

struct TasksDesignProperties {
    var name: String
    var taskImage: UIImage?
    var color: UIColor?
}
