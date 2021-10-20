//
//  TaskScreenViewController.swift
//  petNames
//
//  Created by Enzo Degrazia on 19/10/21.
//

import UIKit

class TaskScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var taskTableView: UITableView!

    var tasks: [String] = ["Water", "Food", "Vet"]

    override func viewDidLoad() {
        super.viewDidLoad()

        taskTableView.delegate = self
        taskTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskScreen-cell", for: indexPath)
//        taskTitle.text = tasks.first

        return cell
    }
}
