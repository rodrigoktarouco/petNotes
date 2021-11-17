//
//  OnboardingViewController.swift
//  petNames
//
//  Created by Rodrigo Kroef Tarouco on 11/11/21.
//

import UIKit

class OnboardingViewController: UIViewController {
    @IBOutlet weak var onboarding1TextLabel: UILabel!
    weak var delegate: OnboardingControlDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        onboarding1TextLabel.text = "onboarding1TextLabel".localized()
        }
}
