//
//  ViewController.swift
//  petNames
//
//  Created by Enzo Degrazia on 15/10/21.
//

import UIKit

class NewPetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var isPressed: Bool = false
    
    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var petTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // Setting image
//                ImagePickerManager().pickImage(self) { image in
//                    self.petImage.image = image
//                    // TODO: Adicionar botão, pedir permissão e salvar a foto
//                    }
        
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
            sectionLabel = "firstSectionLabel".localized()
        case 1:
            sectionLabel = "secondSectionLabel".localized()
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
                
                return cell
                
            } else {
                
                let cell2 = tableView.dequeueReusableCell(withIdentifier: "choose-cell", for: indexPath)
                cell2.textLabel?.text = "category".localized()
                
                return cell2 }
            
        } else if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "choose-cell", for: indexPath)
            
            cell.textLabel?.text = "addNewTask".localized()
            
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
    }
    
}

