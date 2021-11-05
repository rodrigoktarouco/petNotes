//
//  SettingsViewController.swift
//  petNames
//
//  Created by Rodrigo Kroef Tarouco on 14/10/21.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var settingsTableView: UITableView!
    @IBOutlet weak var settingsTitleLabel: UILabel!
    @IBOutlet weak var appSettingsBackgroundImage: UIImageView!
    
    let sectionNames: [String] = ["Adjustments", "Contacts", "Developed By"]
    let switchNames: [String] = ["General notifications", "Sound effects", "Dark mode"]
    let contactTypes: [(UIImage?, String)] = [(UIImage(systemName: "envelope"), "Email"), (UIImage(named: "instagramSymbol"), "Instagram")]
    let teamMembers: [String] = ["Dharana Rivas", "Enzo Degrazia", "Guilherme Antonini", "Heitor Kunrath", "Rodrigo Tarouco"]

    override func viewDidLoad() {
        super.viewDidLoad()
        settingsTableView.dataSource = self
        settingsTitleLabel.text = "settingsTitleLabel".localized()
        settingsTableView.delegate = self
        setUpBackground()

        // Do any additional setup after loading the view.
    }
}
extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return switchNames.count
        case 1:
            return contactTypes.count
        case 2:
            return teamMembers.count
        default:
            return 0
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNames.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            guard let cell =  settingsTableView.dequeueReusableCell(withIdentifier: "Adjustments") as? AdjustmentsTableViewCell else { return UITableViewCell() }
            cell.generalNotificationsLabel.text = switchNames[indexPath.row]
            return cell
        } else if indexPath.section == 1 {
            guard let cell =  settingsTableView.dequeueReusableCell(withIdentifier: "Contacts") as? ContactTableViewCell else { return UITableViewCell() }
            cell.contactTitleLabel.text = contactTypes[indexPath.row].1
            cell.contactImageView.image = contactTypes[indexPath.row].0
            return cell
        } else if indexPath.section == 2 {
            guard let cell =  settingsTableView.dequeueReusableCell(withIdentifier: "DevelopedBy") as? DevelopedByTableViewCell else { return UITableViewCell() }
            cell.developerTitleLabel.text = teamMembers[indexPath.row]
            return cell
        }

     let cell = UITableViewCell()
        return cell
    }
}

extension SettingsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        return 50
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))

            let label = UILabel()
            label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label.text = sectionNames[section].localized()
            label.font = .systemFont(ofSize: 20)
            label.textColor = .black

            headerView.addSubview(label)

            return headerView
        }
}
// MARK: Setting BackgroundImage

extension SettingsViewController {
    func setUpBackground() {
        let backGroundAssetName = "background1"
        appSettingsBackgroundImage.image = UIImage(named: backGroundAssetName)
        appSettingsBackgroundImage.alpha = 0.4
    }
}
