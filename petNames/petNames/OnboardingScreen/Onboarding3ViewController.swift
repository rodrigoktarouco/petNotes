//
//  Onboarding3ViewController.swift
//  petNames
//
//  Created by Rodrigo Kroef Tarouco on 11/11/21.
//

import UIKit

class Onboarding3ViewController: UIViewController {
    @IBOutlet weak var onboarding3TextLabel: UILabel!
    @IBOutlet weak var onboarding3LetsStartButton: UIButton!
    weak var delegate: OnboardingControlDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        onboarding3TextLabel.text = "onboarding3TextLabel".localized()
        onboarding3LetsStartButton.layer.cornerRadius = 22
        onboarding3LetsStartButton.setTitle("onboarding3LetsStartButton".localized(), for: .normal)
        onboarding3LetsStartButton.titleLabel?.font =  UIFont(name: "SFProRounded-Bold", size: 20)
        Background.shared.assignBackground(view: self.view)

    }

    @IBAction func onboarding3LetsStartButtonDidPress(_ sender: UIButton) {
        delegate?.didTapNextButton(viewController: self, button: sender)
    }
}
