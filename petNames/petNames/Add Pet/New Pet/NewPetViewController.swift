//
//  ViewController.swift
//  petNames
//
//  Created by Enzo Degrazia on 15/10/21.
//

import UIKit

class NewPetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var petTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        petTableView.delegate = self
        petTableView.dataSource = self

        // Setting UIBarButtonItems
        self.title = "New Pet"
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonAction))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addButtonAction))

        // Setting the View Controller`s outlets
        petImage.layer.cornerRadius = 22

    }

    // Setting the TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        var sectionLabel: String
        let sectionInt: Int = section
        switch sectionInt {
        case 0:
            sectionLabel = "Informations"
        case 1:
            sectionLabel = "Tasks"
        default:
            sectionLabel = ""
        }

        return "\(sectionLabel)"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        var rowsInSection: Int
        switch section {
        case 0:
            rowsInSection = 2
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
                let cell = tableView.dequeueReusableCell(withIdentifier: "textField-cell", for: indexPath)

                return cell } else {

                    let cell2 = tableView.dequeueReusableCell(withIdentifier: "choose-cell", for: indexPath)
                    cell2.textLabel?.text = "Category"

                return cell2 }

        } else if indexPath.section == 1 {

            let cell = tableView.dequeueReusableCell(withIdentifier: "choose-cell", for: indexPath)

            cell.textLabel?.text = "Add new task"

            return cell

        } else {
            guard let cell = (tableView.dequeueReusableCell(withIdentifier: "share-cell", for: indexPath) as? ShareTableViewCell) else {
                return ShareTableViewCell() }

            return cell
        }
        }

    @objc func cancelButtonAction() {
       print("Cancel pressed")
    }

    @objc func addButtonAction() {
       print("Add pressed")
//        let storyboard = UIStoryboard(name: "PetDetails", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "petDetails") as UIViewController
//        present(vc, animated: true, completion: nil)

    }

}
