//
//  repeatTableViewCell.swift
//  petNames
//
//  Created by Enzo Degrazia on 28/10/21.
//

import UIKit

class repeatTableViewCell: UITableViewCell {

    @IBOutlet var repeatLabel: UILabel!
    @IBOutlet weak var frequencyTextField: UITextField!

    // MARK: picker properties
    let picker = ToolbarPickerView()
    var pickerData: [String] = ["never".localized(), "daily".localized()]
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.frequencyTextField.inputView = self.picker
        self.frequencyTextField.inputAccessoryView = self.picker.toolbar

        frequencyTextField.backgroundColor = .systemFill
        frequencyTextField.layer.masksToBounds = true
        frequencyTextField.layer.cornerRadius = 10.0
        frequencyTextField.text = "choose".localized()
        frequencyTextField.textColor = .link

        let myColor = UIColor.link
        frequencyTextField.layer.borderColor = myColor.cgColor
        frequencyTextField.layer.borderWidth = 1.0

        self.picker.delegate = self
        self.picker.dataSource = self
        self.picker.toolbarDelegate = self
        self.picker.reloadAllComponents()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension repeatTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerData.count
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerData[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.frequencyTextField.text = self.pickerData[row]
    }
}

extension repeatTableViewCell: ToolbarPickerViewDelegate {

    func didTapDone() {
        let row = self.picker.selectedRow(inComponent: 0)
        self.picker.selectRow(row, inComponent: 0, animated: false)
        self.frequencyTextField.text = self.pickerData[row]
        self.frequencyTextField.textColor = .link
        self.frequencyTextField.resignFirstResponder()
        frequencyGlobal = self.frequencyTextField.text ?? ""
    }

    func didTapCancel() {
        self.frequencyTextField.text = "choose".localized()
        self.frequencyTextField.textColor = .link
        self.frequencyTextField.resignFirstResponder()
    }
}
