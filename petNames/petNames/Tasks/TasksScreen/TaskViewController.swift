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

    var selectedSegment: SelectedSegmentInTasks = SelectedSegmentInTasks.all

    var taskModel: TaskModel = TaskModel()
    
    var filteredData: [CellInfosStruct] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        taskModel = TaskModel()
        taskModel.generateAllTasks()
        filteredData = taskModel.cellForAllSegment
        print("#\(taskModel.cellForAllSegment)")
        DispatchQueue.main.async {
            self.tasksTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        Background.shared.assignBackground(view: self.view)

        tasksTableView.backgroundView?.backgroundColor = .clear
        
        self.tabBarController?.tabBar.backgroundColor = UIColor(named: "cellColor")
        tasksTableView.dataSource = self
        tasksTableView.delegate = self
        tasksSearchBar.delegate = self
        taskTitleLabel.text = "taskTitleLabel".localized()
        tasksSegmentedControl.setTitle("All".localized(), forSegmentAt: 0)
        tasksSegmentedControl.setTitle("Not done".localized(), forSegmentAt: 1)
        tasksSegmentedControl.setTitle("By Pet".localized(), forSegmentAt: 2)
        tasksSearchBar.placeholder = "tasksSearchBar".localized()
    }

    // MARK: Reloads the data if detects changes from dark to light mode or vice versa
    // because the borders of the cells are CGColor (doesn't update automatically)
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        tasksTableView.reloadData()
    }
    
}

extension TaskViewController: UISearchBarDelegate {
    
// MARK: Search Bar Config
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredData = taskModel.cellForAllSegment
            
        } else {
            filteredData = taskModel.cellForAllSegment.filter({ task in
                if task.taskName.lowercased().contains(searchText.lowercased()) {
                    return true
                } else {
                    return false
                }
            })
            
        }

        DispatchQueue.main.async {
            self.tasksTableView.reloadData()
        }

    }
}

// MARK: - UITableViewDataSource
extension TaskViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredData.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tasksTableView.dequeueReusableCell(withIdentifier: "reloadableTaskCell" )
        guard let safeCell = cell as? TaskTableViewCell else {
            return UITableViewCell()
        }
        
        let section = indexPath.section
        let myInfosCell = filteredData[section]
        safeCell.delegate = self
        
        safeCell.taskNameLabel.text = myInfosCell.taskName
        safeCell.taskTimeLabel.text = myInfosCell.taskTime
        safeCell.petNameLabel.text = myInfosCell.taskPetName
        safeCell.petImageTask.image = myInfosCell.taskPetImage
        safeCell.myTaskInPersistance = myInfosCell.taskInPersistance
        safeCell.executionDate = myInfosCell.dateForThisExecution
        safeCell.clicked = myInfosCell.isCheckedAsDone

        // MARK: Sets the color of the cell`s inside
        let insideColor = TasksDesign.shared.getTaskDesignProperties(myInfosCell.taskName).color
        safeCell.backgroundColor = insideColor

        // MARK: Sets the color of the cell`s border
        let borderColor = TasksDesign.shared.getTasksCellBorder(myInfosCell.taskName).color
        safeCell.layer.borderColor = borderColor.cgColor

        // MARK: Sets the color of the cell`s checkMark
        let checkMarkColor = UIColor(named: "TC-checkMark")
        safeCell.taskCheckedImage.tintColor = checkMarkColor

        if myInfosCell.isCheckedAsDone {
            safeCell.taskCheckedImage.image = UIImage(systemName: "checkmark.circle.fill")
            safeCell.taskCheckedImage.tintColor = UIColor(named: "CheckMarkClicked")
        } else {
            safeCell.taskCheckedImage.image = UIImage(systemName: "checkmark.circle")
        }
        return safeCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let storyboard = UIStoryboard(name: "Task", bundle: nil)
        let viewC = storyboard.instantiateViewController(withIdentifier: "navigateTo") as UIViewController
        self.present(viewC, animated: true, completion: nil)
        tasksTableView.deselectRow(at: indexPath, animated: true)
        comingFromTaskScreen = true

        let selectedCell = tableView.cellForRow(at: indexPath) as? TaskTableViewCell
        selectedTaskGlobal = selectedCell?.taskNameLabel.text ?? "error"

    }

}

// MARK: PresentMyAlertDelegate
extension TaskViewController: PresentMyAlertDelegate {
    func presentThisAlert(thisAlert: UIAlertController) {
        self.present(thisAlert, animated: true)
    }
}
