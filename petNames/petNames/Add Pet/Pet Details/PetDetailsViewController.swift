//
//  PetDetailsViewController.swift
//  petNames
//
//  Created by Guilherme Valent Antonini on 18/10/21.
//

import UIKit

class PetDetailsViewController: UIViewController {

    var petData: PetsInfosForPetDetails?
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var bigTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavController()
        bigTableView.dataSource = self
        bigTableView.delegate = self
        setUpBackground()
    }

    func setUpBackground() {
        let backGroundAssetNames = ["background1", "background2", "background3"]
        backgroundImageView.image = UIImage(named: backGroundAssetNames.randomElement() ?? "background1") ?? UIImage(named: "")
        backgroundImageView.alpha = 0.4
        bigTableView.backgroundColor = .clear
    }

    func setUpNavController() {
        self.title = "Details"
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "cancelButton".localized().capitalized,
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(editButtonAction))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "edit".localized().capitalized,
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
        switch section {
        case 0:
            return 1
        case 1:
            return petData?.petTaskNames?.count ?? 0
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            let cell =  bigTableView.dequeueReusableCell(withIdentifier: "TopInfosTableViewCell")
            guard let cell = cell as? TopInfosTableViewCell else {
                return  UITableViewCell()
            }
            cell.petImage.image = petData?.petImage
            cell.name.text = petData?.name.capitalized
            cell.category.text = petData?.petClassification?.capitalized
            return cell
        } else if indexPath.section == 1 {
            let cell =  bigTableView.dequeueReusableCell(withIdentifier: "TasksEnumerationTableViewCell")
            guard let cell = cell as? TasksEnumerationTableViewCell else {
                return  UITableViewCell()
            }
            cell.taskImage.image = TasksDesign.shared.getTaskDesignProperties(petData?.petTaskNames?[indexPath.row] ?? "").taskImage
            cell.taskName.text = petData?.petTaskNames?[indexPath.row].capitalized
            return cell
        }
        return  UITableViewCell()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

}

extension PetDetailsViewController: UITableViewDelegate {

}
