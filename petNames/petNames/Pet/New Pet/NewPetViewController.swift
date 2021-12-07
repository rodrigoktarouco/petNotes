//
//  ViewController.swift
//  petNames
//
//  Created by Enzo Degrazia on 15/10/21.
//

import UIKit

public var textFieldInput: String = ""
public var categoryPicked = false
public var categoryGlobal: String = ""

// MARK: Cheks if the view is being called by the edit button on the pet's details screen
public var comingFromPetDetails: Bool = false
public var incomingPetInfos: PetsInfosForPetDetails = PetsInfosForPetDetails()

class NewPetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var petTableView: UITableView!
    @IBOutlet var editImageBtn: UIImageView!
    @IBOutlet weak var editImageView: UIView!
    @IBOutlet weak var editLabel: UILabel!
    @IBOutlet weak var navBarView: UIView!
    @IBOutlet weak var petImageTopConstraint: NSLayoutConstraint!

    // MARK: Instantiates a Pet and a Task object
    let pet = Pet()
    var myPetTasks: [Task] = []

    // MARK: Instantiates the image manager
    var imageManager = ImagePickerManager()

    // MARK: Variables
    var isPressed: Bool = false
    var imageDesignName = ""
    var userDidntSelectPersonalImage: Bool = true

    weak var feedInstance: FeedViewController?

    @IBAction func pickImageButton(_ sender: UIButton) {
        // MARK: Setting image
        imageManager.requestPermissions()
        imageManager.pickImage(self) { image in
            self.petImage.image = image
            self.userDidntSelectPersonalImage = false
            self.petImage.layer.cornerRadius = 50
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Background.shared.assignBackground(view: self.view)
        DispatchQueue.main.async {
            self.petTableView.reloadData()

            // MARK: Setting the pet image
            if comingFromPetDetails == true {
                self.petImage.image = incomingPetInfos.petImage
                self.petImage.layer.cornerRadius = 50
                self.petImage.clipsToBounds = true
                //                self.petImageTopConstraint.constant = 83 // fixes the petImage top constraint
            } else {
                // MARK: Generates a random image placeholder
                let placeHolderImages = ["profile-amarelo-rounded", "profile-azul-rounded", "profile-laranja-rounded", "profile-roxo-rounded", "profile-verde-rounded", "profile-vermelho-rounded"]
                self.imageDesignName = placeHolderImages.randomElement() ?? "profile-verde-rounded"
                self.petImage.image = UIImage(named: self.imageDesignName )
                self.petImage.clipsToBounds = true

            }

            // MARK: Sets the "edit image" attributes
            self.editImageView.backgroundColor = UIColor(named: "EditImageView")
            self.editImageView.layer.cornerRadius = 10
            self.editLabel.textColor = UIColor(named: "EditLabel")
            self.editLabel.text = "editImage".localized()
            self.editImageBtn.tintColor = UIColor(named: "EditImage")

            // MARK: Localizable
            var title: String = ""
            var leftButton: String = ""
            var rightButton: String = ""
            var rightButtonAction: Selector

            self.petTableView.delegate = self
            self.petTableView.dataSource = self

            // MARK: Setting UIBarButtonItems
            if comingFromPetDetails == true {
                title = "details".localized()
                leftButton = "cancelButton".localized()
                rightButton = "save".localized()
                rightButtonAction = #selector(self.saveButtonAction)
            } else {
                title = "newPetTitle".localized()
                leftButton = "cancelButton".localized()
                rightButton = "addButton".localized()
                rightButtonAction = #selector(self.addButtonAction)
            }
            self.title = title
            self.navigationController?.isNavigationBarHidden = false
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: leftButton,
                                                                    style: .plain,
                                                                    target: self,
                                                                    action: #selector(self.cancelButtonAction))
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: rightButton,
                                                                     style: .plain,
                                                                     target: self,
                                                                     action: rightButtonAction)
        }

        // MARK: Appends the pet's tasks to our local Task vector
        if comingFromPetDetails == true {
            myPetTasks.append(contentsOf: incomingPetInfos.petTasks ?? [Task()])
        }
        
        // MARK: Register the custom header view.
        petTableView.register(MyCustomHeader.self, forHeaderFooterViewReuseIdentifier: "sectionHeader")
        
    }

    // MARK: When view disappears, sets the comingFromPetDetails var to false again
    override func viewWillDisappear(_ animated: Bool) {
        comingFromPetDetails = false
    }
    
    // MARK: Setting the TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        if comingFromPetDetails == true {
            return 4
        } else {
            return 3
        }
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
            if comingFromPetDetails == true {
                rowsInSection = 1 + (incomingPetInfos.petTaskNames ?? [""]).count
            } else {
                rowsInSection = 1 + myPetTasks.count
            }
        case 2:
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
        // MARK: If the view is being called by the edit button on pet's details, populates the cells with the stored data. Else, populates with the default infos for adding a new pet.
        if comingFromPetDetails == true {
            if indexPath.section == 0 {
                if indexPath.row == 0 {

                    guard let cell = (tableView.dequeueReusableCell(withIdentifier: "textField-cell", for: indexPath) as? TextFieldTableViewCell) else {
                        return TextFieldTableViewCell() }

                    cell.textField.text = incomingPetInfos.name?.capitalized

                    return cell

                } else {
                    guard let cell2 = (tableView.dequeueReusableCell(withIdentifier: "category-cell", for: indexPath)
                                       as? CategoryTableViewCell) else {
                        return CategoryTableViewCell() }

                    cell2.categoryTextField.placeholder = "choose".localized()
                    cell2.categoryTextField.text = incomingPetInfos.petClassification
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

            } else if indexPath.section == 2 {
                guard let cell = (tableView.dequeueReusableCell(withIdentifier: "share-cell", for: indexPath)
                                  as? ShareTableViewCell) else {
                    return ShareTableViewCell() }
                cell.shareLabel.text = "shareLabel".localized()
                return cell

            } else {
                // delete pet cell
                guard let cell = (tableView.dequeueReusableCell(withIdentifier: "deletePet-cell", for: indexPath)
                                  as? DeletePetTableViewCell) else {
                    return DeletePetTableViewCell() }

                cell.deleteLabel.text = "DeletePet".localized()
                return cell
            }

            // MARK: If the view is NOT being called by the edit button on pet's details
        } else {
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
                //                present(viewC, animated: true)
                tableView.deselectRow(at: indexPath, animated: true)
            } else {
                // added tasks
                editTaskAlertTime = true

                let storyboard = UIStoryboard(name: "TaskScreen", bundle: nil)
                let viewC = storyboard.instantiateViewController(withIdentifier: "taskSetting") as UIViewController
                show(viewC, sender: nil)

                let selectedTask = myPetTasks[indexPath.row - 1]
                selectedTaskForEditingAlertTime = selectedTask
                selectedTaskGlobal = selectedTaskForEditingAlertTime.name ?? ""
                tableView.deselectRow(at: indexPath, animated: true)
            }
        } else if indexPath.section == 2 {
            // share
            print("share")
            let title = "sharedAlertTitle".localized()
            let message = "sharedAlertMessage".localized()
            AlertManager.shared.createAlert(title: title, message: message, viewC: self)
            tableView.deselectRow(at: indexPath, animated: true)
        } else {
            // delete pet

        }
    }
    
    // MARK: navigation bar buttons
    @objc func cancelButtonAction() {
        if comingFromPetDetails == true { // BUG: QUANDO ARRASTA A VIEW UM POUCO P/ BAIXO NAO FUNCIONA MAIS
            presentingViewController?.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func addButtonAction() {
        print("#Add pressed")

        if textFieldInput == "" || categoryPicked == false {

            let title = "warning".localized()
            let message = "warningMessage".localized()
            AlertManager.shared.createAlert(title: title, message: message, viewC: self)

        } else {

            let pet = Pet()
            petImage.image = self.petImage.image
            pet.name = textFieldInput
            pet.category = categoryGlobal
            pet.tasks = Set(myPetTasks) as NSSet
            if userDidntSelectPersonalImage == true {
                pet.image = imageDesignName
                petImage.image = nil
            }
            PersistanceManager.shared.savePet(pet: pet, petImage: petImage.image) { _ in
                //                let newNotification = Notification(id: .task, title: "Teste", body: "Está na hora de fazer!", hour: selectedDate?.hour ?? 0, minutes: selectedDate?.minute ?? 0)
                //                LocalNotificationService.shared.schedule(notifications: [newNotification], completion: nil)
                let tasks = pet.tasks?.allObjects as? [Task] ?? []
                var notifications = [Notification]()
                for task in tasks {
                    for alertTime in task.alertTimes {
                        var utcCalendar = Calendar.autoupdatingCurrent
                        utcCalendar.timeZone = TimeZone(identifier: "UTC") ?? .autoupdatingCurrent
                        var baseComps = utcCalendar.dateComponents(in: utcCalendar.timeZone, from: Date())
                        baseComps.hour = alertTime.hour
                        baseComps.minute = alertTime.minute
                        let date = utcCalendar.date(from: baseComps) ?? Date()
                        let finalComps = Calendar.autoupdatingCurrent.dateComponents([.hour, .minute], from: date)
                        print("------------------------------------------------------------")
                        print(finalComps)
                        let newNotification = Notification(title: task.name ?? "", body: "Hora de realizar a task", hour: finalComps.hour ?? 0, minutes: finalComps.minute ?? 0)
                        notifications.append(newNotification)
                    }
                }
                LocalNotificationService.shared.schedule(notifications: notifications, completion: nil)

                PersistanceManager.shared.listPets { result in
                    switch result {
                    case .success(let pets):
                        for pet in pets {
                            print("#\(pet.name)")
                        }
                    default:
                        return
                    }
                }
            }

            PersistanceManager.shared.listPets { result in
                switch result {
                case .success(let pets):
                    for pet in pets {
                        print(pet.name ?? "error")
                    }
                default:
                    print("failure")
                }
            }
            self.navigationController?.dismiss(animated: true, completion: nil)
            textFieldInput = ""
            categoryPicked = false
        }

        self.feedInstance?.reloadVC()

    }

    @objc func saveButtonAction() {
        print("#Save pressed")
    }
}
