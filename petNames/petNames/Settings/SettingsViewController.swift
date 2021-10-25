//
//  SettingsViewController.swift
//  petNames
//
//  Created by Rodrigo Kroef Tarouco on 14/10/21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var settingsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    
    
}
extension SettingsViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section==0 {
        var  cell =  settingsTableView.dequeueReusableCell(withIdentifier: "AdjustmentsTableViewCell") as! AdjustmentsTableViewCell
                return cell
        }
        else if indexPath.section == 1{
            var  cell =  settingsTableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell") as! ContactTableViewCell
            return cell
        }
        else if indexPath.section==2{
            var  cell =  settingsTableView.dequeueReusableCell(withIdentifier: "DevelopedByTableViewCell") as! DevelopedByTableViewCell
            return cell
        }
            
            
     let cell = UITableViewCell()
        return cell
    }
    
    
    
}
