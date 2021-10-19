//
//  PetDetailsViewController.swift
//  petNames
//
//  Created by Guilherme Valent Antonini on 18/10/21.
//

import UIKit

class PetDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        // Setting UIBarButtonItems
        self.title = "Details"
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonAction))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Confirm", style: .plain, target: self, action: #selector(confirmButtonAction))

    }

    @objc func editButtonAction() {
       print("Edit pressed")
    }

    @objc func confirmButtonAction() {
       print("Confirm pressed")
        self.navigationController?.dismiss(animated: true, completion: nil)

//        let storyboard = UIStoryboard(name: "NewPet", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "newPet") as UIViewController
//        show(vc, sender: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
