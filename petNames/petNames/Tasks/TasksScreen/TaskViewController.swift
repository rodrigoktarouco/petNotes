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

    var selectedSegment: SelectedSegmentInTasks = SelectedSegmentInTasks.all

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
        let myInfos: [CellInfosStruct] = getDataForRowAt(selectedSegment, indexPath.item)
        let cell = tasksTableView.dequeueReusableCell(withIdentifier: "reloadableTaskCell" )
        guard let safeCell = cell as? TaskTableViewCell else {
            return UITableViewCell()
        }

        let section = indexPath.section

        safeCell.taskNameLabel.text = myInfos[section].taskName
        safeCell.taskTimeLabel.text = myInfos[section].taskTime
        safeCell.petNameLabel.text = myInfos[section].taskPetName
        safeCell.petImageTask.image = myInfos[section].taskPetImage

        // MARK: Sets the color of the cell`s inside
        let insideColor =  TasksDesign.shared.getTaskDesignProperties(myInfos[section].taskName).color
        safeCell.backgroundColor = insideColor

        // MARK: Sets the color of the cell`s border
        let borderColor = TasksDesign.shared.getTasksCellBorder(myInfos[section].taskName).color
        safeCell.layer.borderColor = borderColor.cgColor

        // MARK: Sets the color of the cell`s checkMark
        let checkMarkColor = UIColor(named: "TC-checkMark")
        safeCell.taskCheckedImage.tintColor = checkMarkColor

        if myInfos[section].isCheckedAsDone {
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
        comingFromTaskScreen = true

        let selectedCell = tableView.cellForRow(at: indexPath) as? TaskTableViewCell
        selectedTaskGlobal = selectedCell?.taskNameLabel.text ?? "error"

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

    func getDataForRowAt(_ selectedSegment: SelectedSegmentInTasks, _ item: Int) -> [CellInfosStruct] {

        let mock_1 = CellInfosStruct(taskName: "vet", taskTime: "12:00", taskPetName: "doguin 1", taskPetImage: UIImage(named: "profile-roxo-rounded") ?? UIImage(), isCheckedAsDone: false)
        let mock_2 = CellInfosStruct(taskName: "medicine", taskTime: "12:00", taskPetName: "doguin 2", taskPetImage: UIImage(named: "profile-azul-rounded") ?? UIImage(), isCheckedAsDone: false)
        let mock_3 = CellInfosStruct(taskName: "wash", taskTime: "12:00", taskPetName: "gatin 1", taskPetImage: UIImage(named: "profile-verde-rounded") ?? UIImage(), isCheckedAsDone: false)
        let mock_4 = CellInfosStruct(taskName: "playtime", taskTime: "12:00", taskPetName: "passarin 1", taskPetImage: UIImage(named: "profile-vermelho-rounded") ?? UIImage(), isCheckedAsDone: false)
        let mock_5 = CellInfosStruct(taskName: "food", taskTime: "12:00", taskPetName: "gatin 2", taskPetImage: UIImage(named: "profile-amarelo-rounded") ?? UIImage(), isCheckedAsDone: false)
        let mock_6 = CellInfosStruct(taskName: "groom", taskTime: "12:00", taskPetName: "doguin 3", taskPetImage: UIImage(named: "profile-laranja-rounded") ?? UIImage(), isCheckedAsDone: false)
        return [mock_1, mock_2, mock_3, mock_4, mock_5, mock_6]
    }

    func getNumberOfTasks(_ selectedSegment: SelectedSegmentInTasks) -> Int {
        return 5
    }
}
