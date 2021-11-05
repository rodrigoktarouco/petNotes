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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
extension TasksEnumerationTableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }


}
