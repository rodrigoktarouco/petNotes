//
//  SettingsViewController.swift
//  petNames
//
//  Created by Rodrigo Kroef Tarouco on 14/10/21.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var settingsTableView: UITableView!
    @IBOutlet weak var appSettingBackgroundImage: UIImageView!
    @IBOutlet weak var settingsTitleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBackground()
        settingsTableView.dataSource = self
        settingsTitleLabel.text = "settingsTitleLabel".localized()

        // Do any additional setup after loading the view.
    }
}
extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
         let cell =  settingsTableView.dequeueReusableCell(withIdentifier: "AdjustmentsTableViewCell") as! AdjustmentsTableViewCell
                return cell
        } else if indexPath.section == 1 {
            let cell =  settingsTableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell") as! ContactTableViewCell
            return cell
        } else if indexPath.section == 2 {
            let cell =  settingsTableView.dequeueReusableCell(withIdentifier: "DevelopedByTableViewCell") as! DevelopedByTableViewCell
            return cell
        }

     let cell = UITableViewCell()
        return cell
    }
}

// MARK: Settings background
extension SettingsViewController {
    func setUpBackground() {
        let backGroundAssetNames = ["background1", "background2", "background3"]
        appSettingBackgroundImage.image = UIImage(named: backGroundAssetNames.randomElement() ?? "background1") ?? UIImage(named: "")
        appSettingBackgroundImage.alpha = 0.4

    }
}
