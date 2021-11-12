//
//  TaskSettingsViewController.swift
//  petNames
//
//  Created by Enzo Degrazia on 28/10/21.
//

import UIKit

public var frequencyGlobal: String = ""
public var comingFromTaskScreen: Bool = false

class TaskSettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var taskSettingsTableView: UITableView!
    
    var task: Task = Task()
    var newPetVC: UIViewController?
    
    var numberOfAlerts = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Background.shared.assignBackground(view: self.view)
        
        taskSettingsTableView.delegate = self
        taskSettingsTableView.dataSource = self
        
        // MARK: Register the custom header view.
        taskSettingsTableView.register(MyCustomHeader.self, forHeaderFooterViewReuseIdentifier: "sectionHeader")
        
        // MARK: NavigationBar config
        self.title = selectedTaskGlobal
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "save".localized(),
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(saveButtonAction))
        if comingFromTaskScreen == true {
            self.title = selectedTaskGlobal
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "cancel".localized(),
                                                                    style: .plain,
                                                                    target: self,
                                                                    action: #selector(cancelButtonAction))
            comingFromTaskScreen = false
        }
    }

// MARK: navigation bar buttons
@objc func saveButtonAction() {

    // MARK: Initializes the Task object
    task.name = selectedTaskGlobal
    task.repetition = frequencyGlobal
    task.initialDate = Date()
    //       task.observations =

    // MARK: returns to the first view of the flow
    self.navigationController?.popToRootViewController(animated: true)

    // MARK: Accesses NewPetViewController
    guard let newPetVC = self.navigationController?.topViewController as? NewPetViewController else {
        return
    }
    newPetVC.myPetTasks.append(task)
    print(newPetVC.myPetTasks)
    newPetVC.petTableView.reloadData()

}

@objc func cancelButtonAction() {
    self.navigationController?.dismiss(animated: true, completion: nil)
}

// MARK: TableView config
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == 0 {
        if indexPath.row == 0 {

            return 52

        } else {

            return 52
        }
    } else if indexPath.section == 1 {

        return 52

    } else {

        return 150
    }
}

func numberOfSections(in tableView: UITableView) -> Int {
    return 3
}

func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "sectionHeader")
            as? MyCustomHeader else {
                return MyCustomHeader() }

    var sectionLabel: String
    let sectionInt: Int = section

    switch sectionInt {
    case 0:
        sectionLabel = "Warning".localized()
    case 1:
        sectionLabel = ""
    default:
        sectionLabel = "Notes".localized()
    }

    let boldString = NSAttributedString(string: sectionLabel)
    view.title.attributedText = NSMutableAttributedString()
        .bold(boldString.string)

    return view
}

func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    var headerHeight: CGFloat
    let sectionInt: Int = section

    switch sectionInt {
    case 0:
        headerHeight = 38
    case 1:
        headerHeight = 0
    default:
        headerHeight = 38
    }
    return headerHeight
}

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    var rowsInSection: Int
    switch section {
    case 0:
        rowsInSection = 1 + numberOfAlerts // Accordingly to how many alerts
    case 1:
        rowsInSection = 1
    default:
        rowsInSection = 1
    }

    return rowsInSection
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
        if indexPath.row == 0 {
            // add new warning
            guard let cell = (taskSettingsTableView.dequeueReusableCell(withIdentifier: "addWarning-cell", for: indexPath)
                              as? AddWarningTableViewCell) else {
                return AddWarningTableViewCell() }

            cell.addWarningLabel.text = "addNewWarning".localized()
            cell.alertImage.image = UIImage(named: "alerta")
            cell.accessoryView = UIImageView(image: UIImage(systemName: "chevron.right"))
            cell.accessoryView?.tintColor = UIColor(named: "headerTitleColor")

            return cell

        } else {
            // warning cell
            guard let cell2 = (taskSettingsTableView.dequeueReusableCell(withIdentifier: "warning-cell", for: indexPath)
                               as? WarningTableViewCell) else {
                return WarningTableViewCell() }

            return cell2
        }
    } else if indexPath.section == 1 {

        guard let cell = (taskSettingsTableView.dequeueReusableCell(withIdentifier: "repeat-cell", for: indexPath)
                          as? repeatTableViewCell) else {
            return repeatTableViewCell() }

        cell.repeatLabel.text = "repeat".localized()

        return cell

    } else {
        guard let cell = (taskSettingsTableView.dequeueReusableCell(withIdentifier: "notes-cell", for: indexPath)
                          as? notesTableViewCell) else {
            return notesTableViewCell() }

        cell.notesTextView.text = "notes".localized()
        cell.notesTextView.textColor = UIColor.lightGray

        return cell
    }
}

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.section == 0 {
        if indexPath.row == 0 {
            // add new alert
            tableView.deselectRow(at: indexPath, animated: true)
            if numberOfAlerts <= 5 { // maximum 6 alerts
                numberOfAlerts += 1
                taskSettingsTableView.reloadData()
            } else {
                let title = "warning".localized()
                let message = "warningMessage".localized()

                AlertManager.shared.createAlert(title: title, message: message, viewC: self)
            }

        } else {
            // alert
            tableView.deselectRow(at: indexPath, animated: true)
        }

    } else {
        // repeat
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

}
