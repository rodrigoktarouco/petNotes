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
    var shared: TasksDesign = TasksDesign()
    var tasksDesignPropertiesArray: [TasksDesignProperties] = {
        let water = TasksDesignProperties(name: "water", taskImage: UIImage(named: "water"), color: UIColor(red: 0.439, green: 0.843, blue: 1, alpha: 1))
        let food = TasksDesignProperties(name: "food", taskImage: UIImage(named: "food"), color: UIColor(red: 1, green: 0.702, blue: 0.251, alpha: 1))
        let wash = TasksDesignProperties(name: "wash", taskImage: UIImage(named: "wash"), color: UIColor(red: 0.49, green: 0.478, blue: 1, alpha: 1))
        let playtime = TasksDesignProperties(name: "playtime", taskImage: UIImage(named: "playtime"), color: UIColor(red: 0.855, green: 0.561, blue: 1, alpha: 1))
        let walk  = TasksDesignProperties(name: "walk", taskImage: UIImage(named: "walk"), color: UIColor(red: 0.188, green: 0.859, blue: 0.357, alpha: 1))
        let medicine = TasksDesignProperties(name: "medicine", taskImage: UIImage(named: "medicine"), color: UIColor(red: 1, green: 0.412, blue: 0.38, alpha: 1))
        let groom = TasksDesignProperties(name: "groom", taskImage: UIImage(named: "groom"), color: UIColor(red: 1, green: 0.831, blue: 0.149, alpha: 1))
        let vet = TasksDesignProperties(name: "vet", taskImage: UIImage(named: "vet"), color: UIColor(red: 0.251, green: 0.612, blue: 1, alpha: 1))
        let custom = TasksDesignProperties(name: "custom", taskImage: UIImage(named: "custom"), color: UIColor(red: 0.682, green: 0.682, blue: 0.698, alpha: 1))

       return [ water, food, wash, playtime, walk, medicine, groom, vet, custom]
    }()

    func getTaskDesignProperties( _ taskName: String) -> TasksDesignProperties {
        for task in tasksDesignPropertiesArray {
            if task.name.lowercased() == taskName.lowercased() {
                return task
            }
        }
        return tasksDesignPropertiesArray.last ?? TasksDesignProperties(name: "custom", taskImage: UIImage(named: "custom"), color: UIColor(red: 0.682, green: 0.682, blue: 0.698, alpha: 1)) // the last is the custom TasksDesignProperties
    }
}

struct TasksDesignProperties {
    var name: String
    var taskImage: UIImage?
    var color: UIColor?
}
