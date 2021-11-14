//
//  Onboarding2ViewController.swift
//  petNames
//
//  Created by Rodrigo Kroef Tarouco on 11/11/21.
//

import UIKit

class Onboarding2ViewController: UIViewController {
    @IBOutlet weak var onboarding2TextLabel: UILabel!
    @IBOutlet weak var onboarding2BackButton: UIButton!
    @IBOutlet weak var onboarding2Button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        onboarding2TextLabel.text = "onboarding2TextLabel".localized()
        onboarding2Button.layer.cornerRadius = 22
        onboarding2BackButton.setTitle("onboarding2BackButton".localized(), for: .normal)
        onboarding2BackButton.titleLabel?.font =  UIFont(name: "SFProRounded-Regular", size: 20)
    }
    @IBAction func onboardin2ButtonDidPress(_ sender: UIButton) {
    }

    @IBAction func onboarding2BackButtonDidPress(_ sender: Any) {
    }
}
