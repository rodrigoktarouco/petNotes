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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var  cell =  settingsTableView.dequeueReusableCell(withIdentifier: "AdjustmentsTableViewCell") as! AdjustmentsTableViewCell
        
        
        
        
        return cell
    }
    
    
    
}
