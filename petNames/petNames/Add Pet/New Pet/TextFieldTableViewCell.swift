//
//  TextFieldTableViewCell.swift
//  petNames
//
//  Created by Guilherme Valent Antonini on 21/10/21.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()

        textField.attributedText = NSAttributedString(string: "textField".localized(), attributes: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
