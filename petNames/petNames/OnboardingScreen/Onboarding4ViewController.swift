//
//  Onboarding4ViewController.swift
//  petNames
//
//  Created by Rodrigo Kroef Tarouco on 11/11/21.
//

import UIKit

class Onboarding4ViewController: UIViewController {
    @IBOutlet weak var onboarding4SignUpView: UIView!
    @IBOutlet weak var onboarding4HeaderTitleLabel: UILabel!
    @IBOutlet weak var onboarding4SubHeaderTitleLabel: UILabel!
    @IBOutlet weak var onboarding4QuestionLabel: UILabel!
    @IBOutlet weak var onboarding4TextBoxView: UITextField!
    @IBOutlet weak var onboarding4SaveButton: UIButton!
    weak var delegate: OnboardingControlDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Onboarding SigUpVie
        onboarding4SignUpView.round(corners: [.bottomLeft, .bottomRight, .topRight], radius: 90.0)
        // Onboarding Header Title Label
        onboarding4HeaderTitleLabel.text = "onboarding4HeaderTitleLabel".localized()
        onboarding4SubHeaderTitleLabel.text = "onboarding4SubHeaderTitleLabel".localized()
        // Onboarding Question Label
        onboarding4QuestionLabel.text = "onboarding4QuestionLabel".localized()
        // Onboarding Save Button
        onboarding4SaveButton.layer.cornerRadius = 22
        onboarding4SaveButton.setTitle("onboarding4SaveButton".localized(), for: .normal)
        onboarding4SaveButton.titleLabel?.font =  UIFont(name: "SFProRounded-Bold", size: 20)
        Background.shared.assignBackground(view: self.view)
        // Onboarding Text box view
        onboarding4TextBoxView.addTarget(self, action: #selector(onReturn), for: UIControl.Event.editingDidEndOnExit)

    }
    @IBAction func onboarding4SaveDidPress(_ sender: UIButton) {
        delegate?.didTapSaveButton(viewController: self, button: sender)
        dismiss(animated: true)
    }

    @IBAction func onReturn() {
        self.onboarding4TextBoxView.resignFirstResponder()
//        textFieldInput = textField.text ?? "unnamedAnimal"

    }

}

// MARK: Round View Corners
extension UIView {
  func round(corners: UIRectCorner, radius: CGFloat) {
    let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    self.layer.mask = mask
  }
}

extension Onboarding4ViewController {
    func didPressSkipButtons() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let initialController = storyBoard.instantiateInitialViewController()
        let scene = view.window?.windowScene?.delegate as? SceneDelegate
        scene?.window?.rootViewController = initialController

        guard let window = scene?.window else { return }
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}
