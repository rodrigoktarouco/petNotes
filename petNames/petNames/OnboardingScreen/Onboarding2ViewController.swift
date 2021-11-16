//
//  Onboarding2ViewController.swift
//  petNames
//
//  Created by Rodrigo Kroef Tarouco on 11/11/21.
//

import UIKit

class Onboarding2ViewController: UIViewController {
    @IBOutlet weak var onboarding2TextLabel: UILabel!
    weak var delegate: OnboardingControlDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        onboarding2TextLabel.text = "onboarding2TextLabel".localized()
    }
}
