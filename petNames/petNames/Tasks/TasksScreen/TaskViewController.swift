//
//  TaskViewController.swift
//  petNames
//
//  Created by Rodrigo Kroef Tarouco on 14/10/21.
//

import UIKit

class TaskViewController: UIViewController {
    @IBOutlet weak var taskTitleLabel: UILabel!
    @IBOutlet weak var tasksTableView: UITableView!
    @IBOutlet weak var tasksSegmentedControl: UISegmentedControl!
    @IBOutlet weak var tasksSearchBar: UISearchBar!
    var selectedSegment: SelectedSementInTasks = SelectedSementInTasks.all
    override func viewDidLoad() {
        super.viewDidLoad()
        tasksTableView.dataSource = self
        tasksTableView.delegate = self
        taskTitleLabel.text = "taskTitleLabel".localized()
        tasksSegmentedControl.setTitle("All".localized(), forSegmentAt: 0)
        tasksSegmentedControl.setTitle("Not done".localized(), forSegmentAt: 1)
        tasksSegmentedControl.setTitle("By Pet".localized(), forSegmentAt: 2)
        tasksSearchBar.placeholder = "tasksSearchBar".localized()
    }
}

// MARK: - UITableViewDataSource
extension TaskViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getNumberOfTasks(selectedSegment)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myInfos = getDataForRowAt(selectedSegment, indexPath.item)
        let cell = tasksTableView.dequeueReusableCell(withIdentifier: "reloadableTaskCell" )
        guard let safeCell = cell as? TaskTableViewCell else {
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
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Content deleted.")
        }
    }
}
// get informações a serem apresentadas no all, not done, e by pet
extension TaskViewController {
    func getDataForRowAt(_ selectedSegment: SelectedSementInTasks, _ item: Int) -> CellInfosStruct {
        let pittyMockTask = CellInfosStruct(taskName: "Alimentação", taskTime: "12:00", taskPetName: "Pitty", taskPetImage: UIImage(named: "pitty") ?? UIImage(), isCheckedAsDone: false)
        return pittyMockTask
    }
    func getNumberOfTasks(_ selectedSegment: SelectedSementInTasks) -> Int {
        return 5
    }
}
