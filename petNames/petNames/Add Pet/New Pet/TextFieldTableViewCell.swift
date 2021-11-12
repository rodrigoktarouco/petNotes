//
//  TextFieldTableViewCell.swift
//  petNames
//
//  Created by Guilherme Valent Antonini on 21/10/21.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!


    override func awakeFromNib() {
        super.awakeFromNib()

        self.textField.delegate = self

        textField.placeholder = "textField".localized()
//        textField.attributedText = NSAttributedString(string: "textField".localized(), attributes: nil)
        textField.addTarget(self, action: #selector(onReturn), for: UIControl.Event.editingDidEndOnExit)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldInput = ""
    }

    @IBAction func onReturn() {
        self.textField.resignFirstResponder()
        textField.attributedText = NSAttributedString(string: textField.text ?? "", attributes: nil)
//        textFieldInput = textField.text ?? "unnamedAnimal"

    }
    @IBAction func editingIsHapenning(_ sender: Any) {
        textFieldInput = textField.text ?? ""
    }

}
