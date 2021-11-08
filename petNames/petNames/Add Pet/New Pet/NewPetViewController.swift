//
//  ViewController.swift
//  petNames
//
//  Created by Enzo Degrazia on 15/10/21.
//

import UIKit

class NewPetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var isPressed: Bool = false
    var imageManager = ImagePickerManager()
    
    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var petTableView: UITableView!
    
    @IBAction func pickImageButton(_ sender: UIButton) {
        // Setting image
        imageManager.requestPermissions()
        imageManager.pickImage(self) { image in
            self.petImage.image = image
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        Background.shared.assignBackground(view: self.view)
        
        // Localizable
        let newPet = "newPetTitle".localized()
        let cancelButton = "cancelButton".localized()
        let addButton = "addButton".localized()
        petTableView.delegate = self
        petTableView.dataSource = self
        // Setting UIBarButtonItems
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
        
        // Setting the View Controller`s outlets
        petImage.layer.cornerRadius = 22
        
        // Register the custom header view.
        petTableView.register(MyCustomHeader.self, forHeaderFooterViewReuseIdentifier: "sectionHeader")

        

    }
    
    // Setting the TableView
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
            rowsInSection = 1
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

//                cell2.textLabel?.text = "category".localized()
                cell2.categoryLabel.text = "category".localized()
                
                return cell2 }
            
        } else if indexPath.section == 1 {
            
            guard let cell = (tableView.dequeueReusableCell(withIdentifier: "newTask-cell", for: indexPath) as? AddNewTaskTableViewCell) else {
                return AddNewTaskTableViewCell() }
            
//            cell.textLabel?.text = "addNewTask".localized()
            cell.addNewTaskLabel.text = "addNewTask".localized()
            
            return cell
            
        } else {
            guard let cell = (tableView.dequeueReusableCell(withIdentifier: "share-cell", for: indexPath)
                              as? ShareTableViewCell) else {
                return ShareTableViewCell() }
            cell.shareLabel.text = "shareLabel".localized()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                // textField
                print("textfield")
            } else {
                // category
                print("category")
            }
        } else if indexPath.section == 1 {
            // addTask
            print("addTask")
            let storyboard = UIStoryboard(name: "TaskScreen", bundle: nil)
            let viewC = storyboard.instantiateViewController(withIdentifier: "taskScreen") as UIViewController
            show(viewC, sender: nil)
            //            present(viewC, animated: true, completion: nil)
            
        } else {
            // share
            print("share")
        }
    }
    
    @objc func cancelButtonAction() {
        print("Cancel pressed")
        self.navigationController?.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func addButtonAction() {
        print("Add pressed")
        //        let storyboard = UIStoryboard(name: "PetDetails", bundle: nil)
        //        let viewC = storyboard.instantiateViewController(withIdentifier: "petDetails") as UIViewController
        //        present(viewC, animated: true, completion: nil)
        //        show(viewC, sender: nil)
        let pet = Pet()
        pet.name = "tibetiamo"
        PersistanceManager.shared.savePet(pet: pet, petImage: petImage.image) { _ in
            PersistanceManager.shared.listPets { result in
                switch result {
                case .success(let pets):
                    for pet in pets where pet.name == "tibetiamo" {
                        PersistanceManager.shared.getPetImage(pet) { image in
                            print(pet.name, image)
                        }
                    }
                default:
                    return
                }
            }
        }


    }
    
}
