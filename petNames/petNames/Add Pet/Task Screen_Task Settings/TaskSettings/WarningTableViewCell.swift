//
//  alertTableViewCell.swift
//  petNames
//
//  Created by Enzo Degrazia on 28/10/21.
//

import UIKit

class WarningTableViewCell: UITableViewCell {

    @IBOutlet var warningSwitch: UISwitch!
    @IBOutlet var alertTextField: UITextField!
    
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
        toolbar.setItems([doneBtn], animated: true)

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
    
    @objc func donePressed() {
        
        // formatter
        let formatter = DateFormatter()

        formatter.dateStyle = .none
        formatter.timeStyle = .short

        alertTextField.text = formatter.string(from: datePicker.date)
//        timeNotification = datePicker.date
        let formatter2 = DateFormatter()
        formatter2.locale = Locale(identifier: "pt_BR")
        formatter2.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        let newDateString = formatter2.string(from: datePicker.date)
        let newDate = formatter2.date(from: newDateString)
//        self.view.endEditing(true)
        let formatterHour = DateFormatter()
        formatterHour.dateFormat = "HH"
        let formatterMinute = DateFormatter()
        formatterMinute.dateFormat = "mm"
//        ScheduleNotification.shared.preferedHour = Int(formatterHour.string(from: newDate ?? Date()))
//        ScheduleNotification.shared.preferedMinute = Int(formatterMinute.string(from: newDate ?? Date()))
//        confirmedHourNotificationBtn.isEnabled = true
//        confirmedHourNotificationBtn.backgroundColor = UIColor(named: "Verde")
        self.alertTextField.resignFirstResponder()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
