//
//  CustomFont.swift
//  petNames
//
//  Created by Guilherme Valent Antonini on 04/11/21.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    var fontSize_20: CGFloat { return 20 }
    var customFont: UIFont { return UIFont(name: "SFProRounded-Semibold", size: 20) ?? UIFont() }

    func bold(_ value: String) -> NSMutableAttributedString {

        let attributes: [NSAttributedString.Key: Any] = [
            .font: customFont
        ]

        self.append(NSAttributedString(string: value, attributes: attributes))

        return self
    }
}
