//
//  notesTableViewCell.swift
//  petNames
//
//  Created by Enzo Degrazia on 28/10/21.
//

import UIKit

class notesTableViewCell: UITableViewCell {

    @IBOutlet var notesTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if notesTextView.textColor == UIColor.lightGray {
//            notesTextView.text = nil
//            notesTextView.textColor = UIColor.black
//        }
//    }
//
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if notesTextView.text.isEmpty {
//            notesTextView.text = "Notes"
//            notesTextView.textColor = UIColor.lightGray
//        }
//    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
