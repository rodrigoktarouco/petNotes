//
//  TaskScreenViewController.swift
//  petNames
//
//  Created by Enzo Degrazia on 19/10/21.
//

import UIKit

class TaskScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var taskTableView: UITableView!
    
    var tasks: [String] = ["Water", "Food", "Wash", "Playtime", "Walk", "Medicine", "Groom", "Vet"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        taskTableView.delegate = self
        taskTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowsInSection: Int
        switch section {
        case 0:
            rowsInSection = tasks.count
        case 1:
            rowsInSection = 1
        default:
            rowsInSection = 1
        }
        return rowsInSection
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        var sectionLabel: String
        let sectionInt: Int = section

        switch sectionInt {
        case 0:
            sectionLabel = ""
        case 1:
            sectionLabel = " "
        default:
            sectionLabel = ""
        }

        return "\(sectionLabel)"
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = (taskTableView.dequeueReusableCell(withIdentifier: "taskScreen-cell", for: indexPath)
                              as? TaskScreenTableViewCell) else {
                return TaskScreenTableViewCell() }
            
            cell.taskScreenTitleLabel.text = tasks[indexPath.row].localized()

            return cell
        } else {
            guard let cell = (taskTableView.dequeueReusableCell(withIdentifier: "taskScreen-cell", for: indexPath)
                              as? TaskScreenTableViewCell) else {
                return TaskScreenTableViewCell() }

            cell.taskScreenTitleLabel.text = "Custom".localized()

            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "TaskScreen", bundle: nil)
        let viewC = storyboard.instantiateViewController(withIdentifier: "taskSetting") as UIViewController
        show(viewC, sender: nil)
    }
}
