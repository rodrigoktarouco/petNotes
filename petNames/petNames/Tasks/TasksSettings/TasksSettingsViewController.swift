//
//  TasksSettingsViewController.swift
//  petNames
//
//  Created by Heitor Feijó Kunrath on 19/10/21.
//

import UIKit

class TasksSettingsViewController: UIViewController {
    @IBOutlet weak var taskSettingsTitleLabel: UILabel!
    @IBOutlet weak var addNewAlertLabel: UILabel!
    @IBOutlet weak var repeatLabel: UILabel!
    @IBOutlet weak var observationsTitlelabel: UILabel!
    @IBOutlet weak var taskTimesTableView: UITableView!
    @IBOutlet weak var frequencyLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        taskTimesTableView.dataSource = self
        taskTimesTableView.delegate = self

        addNewAlertLabel.text = "addNewAlertLabel".localized()
        taskSettingsTitleLabel.text = "taskSettingsTitleLabel".localized()
        repeatLabel.text = "repeatLabel".localized()
        frequencyLabel.text = "frequencyLabel".localized()
        observationsTitlelabel.text = "observationsTitlelabel".localized()

    }
}

extension TasksSettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
