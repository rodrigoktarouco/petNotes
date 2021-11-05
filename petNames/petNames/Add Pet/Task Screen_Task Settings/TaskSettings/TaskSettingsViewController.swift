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
        Background.shared.assignBackground(view: self.view)

        taskSettingsTableView.delegate = self
        taskSettingsTableView.dataSource = self

        // Register the custom header view.
        taskSettingsTableView.register(MyCustomHeader.self, forHeaderFooterViewReuseIdentifier: "sectionHeader")
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
                                  as? AddWarningTableViewCell) else {
                    return AddWarningTableViewCell() }
                
                cell.addWarningLabel.text = "addNewWarning".localized()
                
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

            cell.repeatLabel.text = "repeat".localized()
//            cell.repeatSecondaryLabel.text = "frequency".localized()
            
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
