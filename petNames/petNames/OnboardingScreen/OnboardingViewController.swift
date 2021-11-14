//
//  OnboardingViewController.swift
//  petNames
//
//  Created by Rodrigo Kroef Tarouco on 11/11/21.
//

import UIKit

class OnboardingViewController: UIViewController {
    @IBOutlet weak var onboarding1TextLabel: UILabel!
    @IBOutlet weak var onboarding1Button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        onboarding1TextLabel.text = "onboarding1TextLabel".localized()
        onboarding1Button.layer.cornerRadius = 22

        }

    @IBAction func onboarding1ButtonDidPressed(_ sender: UIButton) {
    }


}
