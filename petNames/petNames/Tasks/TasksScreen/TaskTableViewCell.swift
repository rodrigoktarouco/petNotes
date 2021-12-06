//
//  TaskTableViewCell.swift
//  petNames
//
//  Created by Rodrigo Kroef Tarouco on 18/10/21.
//

import UIKit

protocol ReloadTableViewProtocol: AnyObject {
    func reloadTableView(_ myStruc: CellInfosStruct)
}

class TaskTableViewCell: UITableViewCell {
    
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var petImageTask: UIImageView!
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var taskTimeLabel: UILabel!
    @IBOutlet weak var petNameLabel: UILabel!
    @IBOutlet weak var taskCheckedImage: UIImageView!
    
    var clicked: Bool?
    var myTaskInPersistance: Task?
    weak var delegate: PresentMyAlertDelegate?
    weak var tableViewReloaderDelegate: ReloadTableViewProtocol?
    var executionDate: Date?
    var myStruct: CellInfosStruct?

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpFonts()
        //        petImageTask.layer.cornerRadius = 22
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 22
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
    }

    func setUpFonts() {
        taskNameLabel.font =  UIFont(name: "SFProRounded-Semibold", size: 17)
        petNameLabel.font = UIFont(name: "SFProRounded-Medium", size: 13)
        taskTimeLabel.font = UIFont(name: "SFProRounded-Semibold", size: 14)
    }

    @IBAction func taskCheckedButton(_ sender: UIButton) {
        if clicked == false {
            let newExecution = Execution()
            newExecution.timeStamp = executionDate
            myTaskInPersistance?.addToExecutions(newExecution)
            PersistanceManager.shared.saveExecution(execution: newExecution) { error in
                if  error == nil {
                    DispatchQueue.main.async {
                        self.taskCheckedImage.image = UIImage(systemName: "checkmark.circle.fill")
                        self.taskCheckedImage.tintColor = UIColor(named: "CheckMarkClicked")
                        self.clicked = true
                        guard let safeStruct = self.myStruct else {return }
                        self.tableViewReloaderDelegate?.reloadTableView(safeStruct)
                    }

                } else {
                    DispatchQueue.main.async {
                        let alertController: UIAlertController = {
                            let controller = UIAlertController(title: "Error",
                                                               message: "Problem saving data",
                                                               preferredStyle: .alert)
                            let correct = UIAlertAction(title: "OK", style: .cancel)
                            controller.addAction(correct)
                            return controller }()
                        self.delegate?.presentThisAlert(thisAlert: alertController)
                    }
                }
            }

        } else {

            let arrayOfExecutions = myTaskInPersistance?.executions?.map({ $0 as? Execution
            })
            guard let safeArrayOfExecutions = arrayOfExecutions else {
                return
            }
            for execution in safeArrayOfExecutions {
                if execution?.timeStamp == executionDate, let execution = execution {
                    PersistanceManager.shared.removeExecution(execution: execution) { error in
                        if error != nil {
                            DispatchQueue.main.async {
                                let alertController: UIAlertController = {
                                    let controller = UIAlertController(title: "Error",
                                                                       message: "Problem deleting data",
                                                                       preferredStyle: .alert)
                                    let correct = UIAlertAction(title: "OK", style: .cancel)
                                    controller.addAction(correct)
                                    return controller }()
                                self.delegate?.presentThisAlert(thisAlert: alertController)
                            }
                        } else {
                            DispatchQueue.main.async {
                                self.taskCheckedImage.image = UIImage(systemName: "checkmark.circle")
                                self.taskCheckedImage.tintColor = UIColor(named: "TC-checkMark")
                                self.clicked = false
                                guard let safeStruct = self.myStruct else {return }
                                self.tableViewReloaderDelegate?.reloadTableView(safeStruct)
                            }

                        }

                    }
                }
            }

        }

    }
}

// MARK: Present Myalert delegate
protocol PresentMyAlertDelegate: AnyObject {
    func presentThisAlert(thisAlert: UIAlertController)
}
