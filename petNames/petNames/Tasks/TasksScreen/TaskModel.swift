//
//  TaskModel.swift
//  petNames
//
//  Created by Rodrigo Kroef Tarouco on 14/10/21.
//

import Foundation
import UIKit

enum SelectedSegmentInTasks {
        case all
        case notDone
        case byPet
        case filter
    }

struct CellInfosStruct {
    var taskName: String
    var taskTime: String
    var taskPetName: String
    var taskPetImage: UIImage
    var isCheckedAsDone: Bool
}
