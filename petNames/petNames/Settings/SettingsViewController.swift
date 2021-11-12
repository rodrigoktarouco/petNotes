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
    let urlAddresses: [URL?] = [URL(string: "https://www.youtube.com/watch?v=dQw4w9WgXcQ"), URL(string: "https://www.youtube.com/watch?v=G1IbRujko-A")]
    let switchNames: [String] = ["General notifications".localized(), "Sound effects".localized(), "Dark mode".localized()]
    let contactTypes: [(UIImage?, String)] = [(UIImage(named: "email"), "Email"), (UIImage(named: "instagram"), "Instagram")]
    let teamMembers: [String] = ["Dharana Rivas", "Enzo Degrazia", "Guilherme Antonini", "Heitor Kunrath", "Rodrigo Tarouco"]
    var notificationsEnabled: Bool = false
    var darkMode: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.backgroundColor = UIColor(named: "cellColor")
        settingsTableView.dataSource = self
        settingsTitleLabel.text = "settingsTitleLabel".localized()
        settingsTableView.delegate = self
        Background.shared.assignBackground(view: self.view)

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
            if indexPath.row == 0 {
                cell.cellType = .notifications
                cell.generalNotificationsSwitch.isOn = notificationsEnabled
            } else if indexPath.row == 1 {
                cell.cellType = .soundEffects
                cell.generalNotificationsSwitch.isOn = LocalNotificationService.shared.customSoundsEnabled
            } else if indexPath.row == 2 {
                cell.cellType = .darkMode
                cell.generalNotificationsSwitch.isOn = darkMode
            }
            cell.delegate = self
            return cell
        } else if indexPath.section == 1 {
            guard let cell =  settingsTableView.dequeueReusableCell(withIdentifier: "Contacts") as? ContactTableViewCell else { return UITableViewCell() }
            cell.contactTitleLabel.text = contactTypes[indexPath.row].1
            cell.contactImageView.image = contactTypes[indexPath.row].0
            cell.url = urlAddresses[indexPath.row]

            return cell
        } else if indexPath.section == 2 {
            guard let cell =  settingsTableView.dequeueReusableCell(withIdentifier: "DevelopedBy") as? DevelopedByTableViewCell else { return UITableViewCell() }
            cell.developerTitleLabel.text = teamMembers[indexPath.row]
            return cell
        }
     let cell = UITableViewCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
            label.textColor = UIColor(named: "headerTitleColor")
            label.font = UIFont(name: "SFProRounded-Semibold", size: 20)

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

// MARK: Adjustments Table view Cell delegte
extension SettingsViewController: AdjustmentsTableViewCellDelegate {
    func didToogleSwitch(cellType: AdjustmentsCellType, isOn: Bool) {
        switch cellType {
        case .notifications:
            if isOn {
                // Ask for user enable notifications on Settings
                LocalNotificationService.shared.requestAuthorizationIfNeeded { [self] success in
                    DispatchQueue.main.async {
                        self.notificationsEnabled = success
                        self.settingsTableView.reloadData()
                    }

                }
            } else {
                // Unschedule all user's notifications
                DispatchQueue.global(qos: .background).async { [weak self] in
                    LocalNotificationService.shared.remove(identifiers: [.task])
                }
                notificationsEnabled = false
                settingsTableView.reloadData()
            }
        case .soundEffects:
            LocalNotificationService.shared.customSoundsEnabled.toggle()
            settingsTableView.reloadData()
        case .darkMode:
            switch isOn {
            case true:
                let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first
                window?.overrideUserInterfaceStyle = .dark
            case false:
                let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first
                window?.overrideUserInterfaceStyle = .light
            }
            self.darkMode.toggle()
            settingsTableView.reloadData()
        }
    }
}
