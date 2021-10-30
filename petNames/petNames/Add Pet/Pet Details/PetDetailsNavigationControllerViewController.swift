//
//  PetDetailsNavigationControllerViewController.swift
//  petNames
//
//  Created by Heitor Feijó Kunrath on 30/10/21.
//

import UIKit

class PetDetailsNavigationControllerViewController: UINavigationController {

    var selectedPetData: PetsInfosForPetDetails?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        let petDetailsVC = PetDetailsViewController()
//        petDetailsVC.petData = selectedPetData
//        pushViewController(petDetailsVC, animated: false)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        super.prepare(for: segue, sender: sender)
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//
//
//    }


}
