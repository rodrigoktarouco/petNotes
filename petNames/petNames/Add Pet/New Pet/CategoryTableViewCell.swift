//
//  CategoryTableViewCell.swift
//  petNames
//
//  Created by Guilherme Valent Antonini on 04/11/21.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryTextField: UITextField!

    // MARK: picker properties
    let picker = ToolbarPickerView()
    var pickerData: [String] = ["dog".localized(), "cat".localized(), "bird".localized(), "other".localized()]

    override func awakeFromNib() {
        super.awakeFromNib()

        self.categoryTextField.inputView = self.picker
        self.categoryTextField.inputAccessoryView = self.picker.toolbar

        self.picker.delegate = self
        self.picker.dataSource = self
        self.picker.toolbarDelegate = self
        self.picker.reloadAllComponents()

    }
}

extension CategoryTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
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
        self.categoryTextField.text = self.pickerData[row]
    }
}

extension CategoryTableViewCell: ToolbarPickerViewDelegate {

    func didTapDone() {
        let row = self.picker.selectedRow(inComponent: 0)
        self.picker.selectRow(row, inComponent: 0, animated: false)
        self.categoryTextField.text = self.pickerData[row]
        self.categoryTextField.textColor = UIColor.systemGray
        self.categoryTextField.resignFirstResponder()
    }

    func didTapCancel() {
        self.categoryTextField.text = nil
        self.categoryTextField.placeholder = "choose".localized()
        self.categoryTextField.resignFirstResponder()
    }
}
