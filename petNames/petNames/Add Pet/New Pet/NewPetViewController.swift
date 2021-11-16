//
//  ViewController.swift
//  petNames
//
//  Created by Enzo Degrazia on 15/10/21.
//

import UIKit

public var textFieldInput: String = ""
public var categoryPicked = false

class NewPetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var petTableView: UITableView!
    @IBOutlet var editImageBtn: UIImageView!
    
    @IBAction func pickImageButton(_ sender: UIButton) {
        // MARK: Setting image
        imageManager.requestPermissions()
        imageManager.pickImage(self) { image in
            self.petImage.image = image
        }
    }
    
    let pet = Pet()
    var myPetTasks: [Task] = []
    
    // MARK: Instantiates
    var imageManager = ImagePickerManager()
    var isPressed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Background.shared.assignBackground(view: self.view)
        self.petTableView.reloadData()
        
        // MARK: Image placeholder
//        let placeHolderImages = ["profile-amarelo", "profile-azul", "profile-laranja", "profile-roxo", "profile-verde", "profile-vermelho"]
//
//        self.petImage.image = UIImage(named: placeHolderImages.randomElement() ?? "placeHolderAsset".localized())

        self.petImage.image = UIImage(named: "profile-roxo-dark")

//        self.petImage.image = UIImage(named: "placeHolderAsset".localized())
        self.petImage.clipsToBounds = true

        editImageBtn.image = UIImage(named: "Group 128")
        
        // MARK: Localizable
        let newPet = "newPetTitle".localized()
        let cancelButton = "cancelButton".localized()
        let addButton = "addButton".localized()
        petTableView.delegate = self
        petTableView.dataSource = self
        
        // MARK: Setting UIBarButtonItems
        self.title = newPet
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: cancelButton,
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(cancelButtonAction))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: addButton,
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(addButtonAction))
        
        // MARK: Setting the View Controller`s outlets
//        petImage.layer.cornerRadius = 22
//        petImage.sizeToFit()
        
        // MARK: Register the custom header view.
        petTableView.register(MyCustomHeader.self, forHeaderFooterViewReuseIdentifier: "sectionHeader")
        
    }
    
    // MARK: Setting the TableView
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
            sectionLabel = "firstSectionLabel".localized()  // informations
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
            headerHeight = 38
        case 1:
            headerHeight = 38
        default:
            headerHeight = 0
        }
        
        return headerHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var rowsInSection: Int
        switch section {
        case 0:
            rowsInSection = 2
        case 1:
            rowsInSection = 1 + myPetTasks.count
        default:
            rowsInSection = 1
        }
        
        return rowsInSection
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "textField-cell", for: indexPath)

                return cell
                
            } else {
                guard let cell2 = (tableView.dequeueReusableCell(withIdentifier: "category-cell", for: indexPath)
                                   as? CategoryTableViewCell) else {
                    return CategoryTableViewCell() }
                
                cell2.categoryTextField.placeholder = "choose".localized()
                cell2.categoryLabel.text = "category".localized()
                
                return cell2 }
            
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                guard let cell = (tableView.dequeueReusableCell(withIdentifier: "newTask-cell", for: indexPath) as? AddNewTaskTableViewCell) else {
                    return AddNewTaskTableViewCell() }
                
                cell.addNewTaskLabel.text = "addNewTask".localized()
                cell.accessoryView = UIImageView(image: UIImage(systemName: "chevron.right"))
                cell.accessoryView?.tintColor = UIColor(named: "headerTitleColor")
                
                return cell } else {
                    if myPetTasks.isEmpty == false {
                        guard let cell2 = (tableView.dequeueReusableCell(withIdentifier: "taskSwitch-cell", for: indexPath) as? TaskSwitchTableViewCell) else {
                            return TaskSwitchTableViewCell() }
                        
                        let lastAppendedTask = myPetTasks[indexPath.row - 1]
                        cell2.taskLabel.text = lastAppendedTask.name
                        cell2.taskIconImage.image = UIImage(named: TasksDesign.shared.pickTaskIcon(task: lastAppendedTask.name ?? ""))
                        
                        return cell2
                    }
                    return UITableViewCell()
                }
            
        } else {
            guard let cell = (tableView.dequeueReusableCell(withIdentifier: "share-cell", for: indexPath)
                              as? ShareTableViewCell) else {
                return ShareTableViewCell() }
            cell.shareLabel.text = "shareLabel".localized()
            return cell
        }
    }
    
    // MARK: navigate when cell is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                // textField
                print("textfield")
                tableView.deselectRow(at: indexPath, animated: true)
            } else {
                // category
                print("category")
                tableView.deselectRow(at: indexPath, animated: true)
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                // addTask
                print("addTask")
                let storyboard = UIStoryboard(name: "TaskScreen", bundle: nil)
                let viewC = storyboard.instantiateViewController(withIdentifier: "taskScreen") as UIViewController
                show(viewC, sender: nil)
                tableView.deselectRow(at: indexPath, animated: true)
            } else {
                tableView.deselectRow(at: indexPath, animated: true)
            }
        } else {
            // share
            print("share")
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    // MARK: navigation bar buttons
    @objc func cancelButtonAction() {
        print("Cancel pressed")
        self.navigationController?.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func addButtonAction() {
        print("Add pressed")
        
        if textFieldInput == "" || categoryPicked == false {
            
            let title = "warning".localized()
            let message = "warningMessage".localized()
            AlertManager.shared.createAlert(title: title, message: message, viewC: self)
            
        } else {
           
            let pet = Pet()
            petImage.image = self.petImage.image
            pet.name = textFieldInput
            PersistanceManager.shared.savePet(pet: pet, petImage: petImage.image) { _ in
                PersistanceManager.shared.listPets { result in
                    switch result {
                    case .success(let pets):
                        for pet in pets {
                            print(pet.name)
                        }
                    default:
                        return
                    }
                }
            }
            self.navigationController?.dismiss(animated: true, completion: nil)
            textFieldInput = ""
            categoryPicked = false
        }
        
    }
    
}
