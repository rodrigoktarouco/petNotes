//
//  AssignBackground.swift
//  petNames
//
//  Created by Enzo Degrazia on 03/11/21.
//

import Foundation
import UIKit

class Background {
    private init() {}
    static let shared = Background()
    
    func assignBackground(view: UIView) {
        
        let backGroundAssetNames = ["background1", "background2", "background3"]
        let background = UIImage(named: backGroundAssetNames.randomElement() ?? "background1") ?? UIImage(named: "")
        
        var imageView: UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        imageView.alpha = 1.0
        view.addSubview(imageView)
        view.sendSubviewToBack(imageView)
        
    }
}
