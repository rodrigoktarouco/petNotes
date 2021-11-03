//
//  PetDetailsViewController.swift
//  petNames
//
//  Created by Guilherme Valent Antonini on 18/10/21.
//

import UIKit

class PetDetailsViewController: UIViewController {
    var petData: PetsInfosForPetDetails?
    @IBOutlet weak var bigTableView: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavController()
        bigTableView.dataSource = self

    }
    func setUpNavController() {
        self.title = "Details"
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit",
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(editButtonAction))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Confirm",
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(confirmButtonAction))
    }
    @objc func editButtonAction() {
        print("Edit pressed")
    }

    @objc func confirmButtonAction() {
        print("Confirm pressed")
        self.navigationController?.dismiss(animated: true, completion: nil)

    }
}
extension PetDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
           var cell =  bigTableView.dequeueReusableCell(withIdentifier: "TopInfosTableViewCell")
            guard let cell = cell as? TopInfosTableViewCell else {
                return  UITableViewCell()
            }
            cell.petImage.image = UIImage(named: "pitty")
            cell.name.text = "Pitty"
            cell.nameIsNext.text = "nome:"
            
            return cell
        }
        return  UITableViewCell()
    }




}

