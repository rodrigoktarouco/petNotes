//
//  TaskSettingsViewController.swift
//  petNames
//
//  Created by Enzo Degrazia on 28/10/21.
//

import UIKit

class TaskSettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var taskSettingsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        taskSettingsTableView.delegate = self
        taskSettingsTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                
                return 44
                
            } else {
               
                return 44
            }
        } else if indexPath.section == 1 {
          
            return 44
            
        } else {
          
            return 150
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
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
        
        return "\(sectionLabel)"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var rowsInSection: Int
        switch section {
        case 0:
            rowsInSection = 2 // Accordingly to how many alerts
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
                
                guard let cell = (taskSettingsTableView.dequeueReusableCell(withIdentifier: "addWarning-cell", for: indexPath)
                                  as? AddWarningTableviewCell) else {
                    return AddWarningTableviewCell() }
                
                cell.addWarningLabel.text = "Add new warning".localized()
                
                return cell
                
            } else {
                
                guard let cell2 = (taskSettingsTableView.dequeueReusableCell(withIdentifier: "warning-cell", for: indexPath)
                                  as? warningTableViewCell) else {
                    return warningTableViewCell() }
                
                return cell2
            }
        } else if indexPath.section == 1 {
            
            guard let cell = (taskSettingsTableView.dequeueReusableCell(withIdentifier: "repeat-cell", for: indexPath)
                              as? repeatTableViewCell) else {
                return repeatTableViewCell() }
            
            return cell
            
        } else {
            guard let cell = (taskSettingsTableView.dequeueReusableCell(withIdentifier: "notes-cell", for: indexPath)
                              as? notesTableViewCell) else {
                return notesTableViewCell() }
            
            cell.notesTextView.text = "Notes"
            cell.notesTextView.textColor = UIColor.lightGray
            
            
            return cell
        }
    }

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
