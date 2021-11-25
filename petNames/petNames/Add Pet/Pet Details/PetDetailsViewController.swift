//
//  PetDetailsViewController.swift
//  petNames
//
//  Created by Guilherme Valent Antonini on 18/10/21.
//

import UIKit

class PetDetailsViewController: UIViewController {

    var petData: PetsInfosForPetDetails?
    var chosenPet: Pet?
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var bigTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        Background.shared.assignBackground(view: self.view)

        setUpNavController()
        setUpTableView()

        // MARK: Register the custom header view.
        bigTableView.register(MyCustomHeader.self, forHeaderFooterViewReuseIdentifier: "sectionHeader")

    }

    func setUpTableView() {
        bigTableView.dataSource = self
        bigTableView.delegate = self
        bigTableView.sectionHeaderHeight = 0
        bigTableView.sectionFooterHeight = 0
        bigTableView.contentInsetAdjustmentBehavior = .never

    }

    func setUpNavController() {
        self.title = "Details"
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "cancelButton".localized().capitalized,
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(cancelButtonAction))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "edit".localized().capitalized,
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(editButtonAction))
    }

    @objc func cancelButtonAction() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }

    @objc func editButtonAction() {
        print("edit pressed")

        let storyboard = UIStoryboard(name: "NewPet", bundle: nil)
        let viewC = storyboard.instantiateViewController(withIdentifier: "addPet") as UIViewController
        self.present(viewC, animated: true, completion: nil)
    }
}

// MARK: Setting the TableView
extension PetDetailsViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "sectionHeader")
                as? MyCustomHeader else {
                    return MyCustomHeader() }

        var sectionLabel: String
        let sectionInt: Int = section

        switch sectionInt {
        case 0:
            sectionLabel = ""
        case 1:
            sectionLabel = "secondSectionLabel".localized() // tasks
        default:
            sectionLabel = ""
        }

        let boldString = NSAttributedString(string: sectionLabel)
        view.title.attributedText = NSMutableAttributedString()
            .bold(boldString.string)

        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var headerHeight: CGFloat
        let sectionInt: Int = section

        switch sectionInt {
        case 0:
            headerHeight = 0
        case 1:
            headerHeight = 38
        default:
            headerHeight = 20
        }

        return headerHeight
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return petData?.petTaskNames?.count ?? 0
        case 2:
            return 1
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 190
        } else {
            return 52
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
            cell.name.textColor = UIColor(named: "headerTitleColor")
            cell.nameIsNext.textColor = UIColor(named: "EditLabel")
            cell.category.text = petData?.petClassification?.capitalized
            cell.category.textColor = UIColor(named: "headerTitleColor")
            cell.categoryIsNext.textColor = UIColor(named: "EditLabel")
//            cell.tasksAreNextLabel.textColor = UIColor(named: "headerTitleColor")
            return cell
        } else if indexPath.section == 1 {
            let cell =  bigTableView.dequeueReusableCell(withIdentifier: "TasksEnumerationTableViewCell")
            guard let cell = cell as? TasksEnumerationTableViewCell else {
                return  UITableViewCell()
            }
            cell.taskImage.image = TasksDesign.shared.getTaskDesignProperties(petData?.petTaskNames?[indexPath.row] ?? "").taskImage
            cell.taskName.text = petData?.petTaskNames?[indexPath.row].capitalized
            cell.taskName.textColor = UIColor(named: "headerTitleColor")
            cell.backgroundColor = UIColor(named: "cellColor")
            let countTasks: Int = petData?.petTaskNames?.count ?? 0
            if indexPath.row == countTasks - 1 {
                cell.separatorView.removeFromSuperview()
            }
            return cell
        } else {
            let cell =  bigTableView.dequeueReusableCell(withIdentifier: "sharedWith-cell")
            guard let cell = cell as? SharedWithTableViewCell else {
                return  UITableViewCell()
            }
            cell.backgroundColor = UIColor(named: "cellColor")
            let sharedText = "sharedWith".localized()
            cell.sharedWithLabel.text = sharedText
            cell.sharedWithLabel.textColor = UIColor(named: "headerTitleColor")
            cell.sharedWithImage.image = UIImage(systemName: "person.circle")
            cell.sharedWithImage.tintColor = UIColor(named: "headerTitleColor")

            return cell
        }
        return  UITableViewCell()
    }
}
