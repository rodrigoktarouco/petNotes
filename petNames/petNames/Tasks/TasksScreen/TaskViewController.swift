//
//  TaskViewController.swift
//  petNames
//
//  Created by Rodrigo Kroef Tarouco on 14/10/21.
//

import UIKit

class TaskViewController: UIViewController {
    
    
    @IBOutlet weak var tasksTableView: UITableView!
    @IBOutlet weak var tasksSegmentedControl: UISegmentedControl!
    @IBOutlet weak var tasksSearchBar: UISearchBar!
    
    var selectedSegment : selectedSementInTasks = selectedSementInTasks.all
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tasksTableView.dataSource = self
        tasksTableView.delegate = self
    }
    
    
}
//MARK: - UITableViewDataSource
extension TaskViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getNumberOfTasks(selectedSegment)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myInfos = getDataForRowAt(selectedSegment, indexPath.item)
        let cell = tasksTableView.dequeueReusableCell(withIdentifier: "reloadableTaskCell" )
        
        
        guard let safeCell = cell as? TaskTableViewCell else{
            return UITableViewCell()
        }
        
        safeCell.taskNameLabel.text = myInfos.taskName
        safeCell.taskTimeLabel.text = myInfos.taskTime
        safeCell.petNameLabel.text = myInfos.taskPetName
        safeCell.petImageTask.image = myInfos.taskPetImage
        
        if myInfos.isCheckedAsDone {
            safeCell.taskCheckedImage.image = UIImage(systemName: "checkmark.circle.fill")
            
        } else {
            safeCell.taskCheckedImage.image = UIImage(systemName: "checkmark.circle")
        }
        
        return safeCell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        
        let storyboard = UIStoryboard(name: "Task", bundle: nil)
        let settingsController = storyboard.instantiateViewController(identifier: "NavigationControllerOfTasksSettingsView")
        self.present(settingsController, animated: true, completion: nil)
        
        
    }
    
}
// get informações a serem apresentadas no all, not done, e by pet
extension TaskViewController {
    
    func getDataForRowAt(_ selectedSegment:selectedSementInTasks ,_ item : Int) -> cellInfosStruct {
        
        
        let pittyMockTask = cellInfosStruct(taskName: "Alimentação", taskTime: "12:00", taskPetName: "Pitty", taskPetImage: UIImage(named: "pitty") ?? UIImage(), isCheckedAsDone: false)
        
        
        return pittyMockTask
    }
    func getNumberOfTasks(_ selectedSegment:selectedSementInTasks) -> Int {
        
        return 5
        
    }
    
    
}

enum selectedSementInTasks {
    case all
    case notDone
    case byPet
    case filter
}

struct cellInfosStruct {
    var taskName: String
    var taskTime: String
    var taskPetName: String
    var taskPetImage : UIImage
    var isCheckedAsDone : Bool
}

