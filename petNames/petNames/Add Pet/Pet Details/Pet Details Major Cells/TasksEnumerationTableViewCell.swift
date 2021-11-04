//
//  TasksEnumerationTableViewCell.swift
//  petNames
//
//  Created by Heitor Feijó Kunrath on 03/11/21.
//

import UIKit

class TasksEnumerationTableViewCell: UITableViewCell {
    var taskNames: [String]?
    @IBOutlet weak var littleTableView: UITableView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        littleTableView.dataSource = self
        littleTableView.layer.cornerRadius = 12
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
extension TasksEnumerationTableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return taskNames?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

       let cell =  littleTableView.dequeueReusableCell(withIdentifier: "SmallTableViewCell")
        guard let cell = cell as? SmallTableViewCell else {
            return UITableViewCell()
        }
        print("jnjkNJKASNJ")
        print(taskNames?[indexPath.row])
        cell.taskName.text = taskNames?[indexPath.row] ?? ""
        cell.taskImage.image = TasksDesign.shared.getTaskDesignProperties(taskNames?[indexPath.row] ?? "").taskImage
        
        return cell
    }
}
