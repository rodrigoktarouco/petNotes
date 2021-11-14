//
//  Onboarding3ViewController.swift
//  petNames
//
//  Created by Rodrigo Kroef Tarouco on 11/11/21.
//

import UIKit

class Onboarding3ViewController: UIViewController {
    @IBOutlet weak var onboarding3TextLabel: UILabel!
    @IBOutlet weak var onboarding3SkipButton: UIButton!
    @IBOutlet weak var onboarding3LetsStartButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        onboarding3TextLabel.text = "onboarding2TextLabel".localized()
        onboarding3SkipButton.layer.cornerRadius = 22
        onboarding3SkipButton.setTitle("onboarding3SkipButton".localized(), for: .normal)
        onboarding3SkipButton.titleLabel?.font =  UIFont(name: "SFProRounded-Regular", size: 20)
        onboarding3LetsStartButton.layer.cornerRadius = 22
        onboarding3LetsStartButton.setTitle("onboarding3LetsStartButton".localized(), for: .normal)
        onboarding3LetsStartButton.titleLabel?.font =  UIFont(name: "SFProRounded-Bold", size: 20)

    }

    @IBAction func onboarding3LetsStartButtonDidPress(_ sender: UIButton) {
    }
    @IBAction func onboarding3BackButtonDidPress(_ sender: UIButton) {
    }

}
