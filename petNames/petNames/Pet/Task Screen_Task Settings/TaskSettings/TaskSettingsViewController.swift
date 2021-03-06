//
//  TaskSettingsViewController.swift
//  petNames
//
//  Created by Enzo Degrazia on 28/10/21.
//

import UIKit

public var frequencyGlobal: String = ""
public var comingFromTaskScreen: Bool = false
public var alertsGlobal: [DateComponents] = []
public var editTaskAlertTime: Bool = false
public var selectedTaskForEditingAlertTime: Task = Task()

class TaskSettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DatePickerDelegate {
    func didSelectDate(date: DateComponents) {
        selectedDate = date
    }
    @IBOutlet var taskSettingsTableView: UITableView!
    @IBOutlet weak var navView: UIView!
    
    var task: Task = Task()
    var newPetVC: UIViewController?
    var selectedDate: DateComponents?
    var numberOfAlerts = 1

    // MARK: Used to load the time components of the already added tasks, when user wants to edit it
    var localAddedTasksTimes: [DateComponents] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Background.shared.assignBackground(view: self.view)
        
        taskSettingsTableView.delegate = self
        taskSettingsTableView.dataSource = self

        navView.isHidden = true
        
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
            navView.isHidden = false
        }
    }

    // MARK: When view disappears, sets the editTaskAlertTime var to false again
    override func viewWillDisappear(_ animated: Bool) {
        editTaskAlertTime = false
    }

    // MARK: navigation bar buttons
    @objc func saveButtonAction() {
        print("#\(frequencyGlobal)")
        if frequencyGlobal == "" {
            let title1 = "warning".localized()
            let message1 = "warningMessage".localized()
            AlertManager.shared.createAlert(title: title1, message: message1, viewC: self)
        } else {

            // MARK: Initializes the Task object
            task.name = selectedTaskGlobal
            task.repetition = frequencyGlobal
            task.initialDate = Date()
            task.alertTimes = alertsGlobal
            print(task.alertTimes)
            alertsGlobal = []
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
            if editTaskAlertTime == false {
                rowsInSection = 1 + numberOfAlerts // Accordingly to how many default number of alerts
            } else {
                rowsInSection = 1 + selectedTaskForEditingAlertTime.alertTimes.count // If we're editing the task
            }
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

                if editTaskAlertTime == false {
                    cell2.delegate = self
                    return cell2

                } else {
//                    print("#\(selectedTaskForEditingAlertTime.alertTimes)")
                    let dateComponents: [DateComponents] = selectedTaskForEditingAlertTime.alertTimes

                    let dateComponent = dateComponents[indexPath.row - 1]

                    let hour = dateComponent.hour ?? 0
                    let minute = dateComponent.minute ?? 0
                    var utcCalendar = Calendar.current
                    utcCalendar.timeZone = TimeZone(identifier: "UTC") ?? TimeZone.current
                    let date = utcCalendar.date(bySettingHour: hour, minute: minute, second: 0, of: Date())
                    cell2.datePicker.date = date ?? Date()
                    cell2.setFormatDate(date: date ?? Date())

                    cell2.delegate = self
                    return cell2
                }

            }
        } else if indexPath.section == 1 {

            guard let cell = (taskSettingsTableView.dequeueReusableCell(withIdentifier: "repeat-cell", for: indexPath)
                              as? repeatTableViewCell) else {
                return repeatTableViewCell() }

            if editTaskAlertTime == false { // if creating a new pet
                cell.repeatLabel.text = "repeat".localized()
                return cell
            } else { // if editing an existing pet info
                cell.frequencyTextField.placeholder = "choose".localized()
                cell.frequencyTextField.text = selectedTaskForEditingAlertTime.repetition

                return cell
            }

        } else {
            guard let cell = (taskSettingsTableView.dequeueReusableCell(withIdentifier: "notes-cell", for: indexPath)
                              as? notesTableViewCell) else {
                return notesTableViewCell() }

            if editTaskAlertTime == false { // if creating a new pet
                cell.notesTextView.text = "notes".localized()
                cell.notesTextView.textColor = UIColor.lightGray
                return cell
            } else { // if editing an existing pet info
//                print("#\(selectedTaskForEditingAlertTime.observations)")
                cell.notesTextView.text = selectedTaskForEditingAlertTime.observations
                cell.notesTextView.textColor = UIColor.lightGray
                return cell
            }

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
                    let message = "exceedMessage".localized()

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
