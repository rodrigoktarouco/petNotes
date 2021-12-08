//
//  alertTableViewCell.swift
//  petNames
//
//  Created by Enzo Degrazia on 28/10/21.
//

import UIKit

protocol DatePickerDelegate: AnyObject {
    func didSelectDate(date: DateComponents)
}

class WarningTableViewCell: UITableViewCell {

    @IBOutlet var warningSwitch: UISwitch!
    @IBOutlet var alertTextField: UITextField!
    weak var delegate: DatePickerDelegate?
    
    let datePicker = UIDatePicker()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        createDatePicker()
        // Initialization code
    }

    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        let spaceBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelBtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(cancelPressed))
        toolbar.setItems([cancelBtn, spaceBtn, doneBtn], animated: true)

        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .time
        alertTextField.textAlignment = .center
        alertTextField.inputAccessoryView = toolbar
        alertTextField.inputView = datePicker
        alertTextField.textColor = .link
//        alertTextField.placeholder = "hourPickerPH".localized()
        alertTextField.text = "hourPickerPH".localized()
        alertTextField.font = UIFont(name: "body", size: 18.0)
        alertTextField.backgroundColor = .systemFill
        alertTextField.layer.masksToBounds = true
        alertTextField.layer.cornerRadius = 10.0
        let myColor = UIColor.link
        alertTextField.layer.borderColor = myColor.cgColor
        alertTextField.layer.borderWidth = 1.0
    }

    func setFormatDate(date: Date) {
        let formatter = DateFormatter()

        formatter.dateStyle = .none
        formatter.timeStyle = .short

        alertTextField.text = formatter.string(from: date)
    }
    
    @objc func cancelPressed() {
        print("#cancel")
        alertTextField.text = "hourPickerPH".localized()
        alertTextField.textColor = .link
        alertTextField.resignFirstResponder()
        
    }
    
    @objc func donePressed() {

        setFormatDate(date: datePicker.date)

        let components = Calendar.current.dateComponents([.hour, .minute], from: datePicker.date)

        alertsGlobal.append(components)

        self.alertTextField.resignFirstResponder()
        delegate?.didSelectDate(date: components)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func didToogleWarningSwitch(_ sender: UISwitch) {
        if sender.isOn {

        } else {
            
        }
    }
}
