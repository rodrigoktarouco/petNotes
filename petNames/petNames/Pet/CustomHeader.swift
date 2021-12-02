//
//  CustomHeader.swift
//  petNames
//
//  Created by Guilherme Valent Antonini on 29/10/21.
//

import Foundation
import UIKit

class MyCustomHeader: UITableViewHeaderFooterView {
    let title = UILabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureContents() {
        title.translatesAutoresizingMaskIntoConstraints = false
//        title.backgroundColor = .blue
        title.font = UIFont.systemFont(ofSize: 20)
        title.textColor = UIColor(named: "headerTitleColor")
        contentView.addSubview(title)

        NSLayoutConstraint.activate([
            // Center the label vertically, and use it to fill the remaining
            // space in the header view.
            title.heightAnchor.constraint(equalToConstant: 30),
            title.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor,
                   constant: -20),
            title.trailingAnchor.constraint(equalTo:
                   contentView.layoutMarginsGuide.trailingAnchor, constant: 20)
//            title.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: -100)
        ])
    }
}
