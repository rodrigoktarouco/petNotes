//
//  TaskScreenViewController.swift
//  petNames
//
//  Created by Enzo Degrazia on 19/10/21.
//

import UIKit

class TaskScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet var taskTableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var tasksNavigationinItem: UINavigationItem!
    
    // swiftlint:disable:next line_length
    var tasks: [String] = ["Water".localized(), "Food".localized(), "Wash".localized(), "Playtime".localized(), "Walk".localized(), "Medicine".localized(), "Groom".localized(), "Vet".localized()]
    
    var filteredData: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Background.shared.assignBackground(view: self.view)
        
        taskTableView.delegate = self
        taskTableView.dataSource = self
        searchBar.delegate = self
        filteredData = tasks
        
        tasksNavigationinItem.title = "taskTitleLabel".localized()
        //        tasksNavigationinItem.backButtonTitle = "backButton".localized()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowsInSection: Int
        switch section {
        case 0:
            rowsInSection = filteredData.count
        case 1:
            rowsInSection = 1
        default:
            rowsInSection = 1
        }
        return rowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = (taskTableView.dequeueReusableCell(withIdentifier: "taskScreen-cell", for: indexPath)
                              as? TaskScreenTableViewCell) else {
                return TaskScreenTableViewCell() }
            
            let iconImage = TasksDesign.shared.pickTaskIcon(task: filteredData[indexPath.row])
            cell.taskScreenTitleLabel.text = filteredData[indexPath.row]
            cell.taskIconImage.image = UIImage(named: iconImage)
            cell.accessoryView = UIImageView(image: UIImage(systemName: "chevron.right"))
            cell.accessoryView?.tintColor = UIColor(named: "headerTitleColor")
            
            return cell
            
        } else {
            guard let cell = (taskTableView.dequeueReusableCell(withIdentifier: "taskScreen-cell", for: indexPath)
                              as? TaskScreenTableViewCell) else {
                return TaskScreenTableViewCell() }
            
            cell.taskScreenTitleLabel.text = "Custom".localized()
            cell.taskIconImage.image = UIImage(named: "custom-task-icon")
            cell.accessoryView = UIImageView(image: UIImage(systemName: "chevron.right"))
            cell.accessoryView?.tintColor = UIColor(named: "headerTitleColor")
            
            return cell
        }
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "TaskScreen", bundle: nil)
        let viewC = storyboard.instantiateViewController(withIdentifier: "taskSetting") as UIViewController
        show(viewC, sender: nil)
    }
    
    // MARK: Search Bar Config
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = searchText.isEmpty ? tasks : tasks.filter({(tasksString: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return tasksString.range(of: searchText, options: [.diacriticInsensitive, .caseInsensitive]) != nil
        })
        
        taskTableView.reloadData()
        
    }
}
