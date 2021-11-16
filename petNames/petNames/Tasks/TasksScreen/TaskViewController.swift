//
//  TaskViewController.swift
//  petNames
//
//  Created by Rodrigo Kroef Tarouco on 14/10/21.
//

import UIKit

class TaskViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var taskTitleLabel: UILabel!
    @IBOutlet weak var tasksTableView: UITableView!
    @IBOutlet weak var tasksSegmentedControl: UISegmentedControl!
    @IBOutlet weak var tasksSearchBar: UISearchBar!

    var selectedSegment: SelectedSementInTasks = SelectedSementInTasks.all

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
    
}

// MARK: - UITableViewDataSource
extension TaskViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return getNumberOfTasks(selectedSegment)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
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

        let insideColor =  TasksDesign.shared.getTaskDesignProperties(myInfos.taskName).color
        safeCell.backgroundColor = insideColor

        if myInfos.isCheckedAsDone {
            safeCell.taskCheckedImage.image = UIImage(systemName: "checkmark.circle.fill")
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
//        selectedTaskGlobal =
        comingFromTaskScreen = true
    }

//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
////            objects.remove(at: indexPath.row)
//            tasksTableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//        }
//    }
}
// get informações a serem apresentadas no all, not done, e by pet
extension TaskViewController {

    func getDataForRowAt(_ selectedSegment: SelectedSementInTasks, _ item: Int) -> CellInfosStruct {
        let pittyMockTask = CellInfosStruct(taskName: "Walk", taskTime: "12:00", taskPetName: "Pitty", taskPetImage: UIImage(named: "profile-vermelho") ?? UIImage(), isCheckedAsDone: false)
        return pittyMockTask
    }

    func getNumberOfTasks(_ selectedSegment: SelectedSementInTasks) -> Int {
        return 5
    }
}
