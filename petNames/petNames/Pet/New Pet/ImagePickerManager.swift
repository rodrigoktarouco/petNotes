//
//  ImagePickerManager.swift
//  petNames
//
//  Created by Guilherme Valent Antonini on 21/10/21.
//

import Foundation
import AVFoundation
import Photos
import UIKit

class ImagePickerManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var picker = UIImagePickerController()
    var alert = UIAlertController(title: "chooseImage".localized(), message: nil, preferredStyle: .actionSheet)
    var viewController: UIViewController?
    var pickImageCallback: ((UIImage) -> Void )?
    private var cameraPermission: Bool = false
    private var galleryPermission: Bool = false

    override init() {
        super.init()
        let cameraAction = UIAlertAction(title: "camera".localized(), style: .default) { _ in
            self.openCamera()
        }
        let galleryAction = UIAlertAction(title: "gallery".localized(), style: .default) { _ in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "cancel".localized(), style: .cancel) { _ in
        }

        // Add the actions
        picker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
    }
    // MARK: Permissions
    func requestPermissions() {
        // Camera permission
        AVCaptureDevice.requestAccess(for: .video) { response in
            if response {
                // access granted
                self.cameraPermission = true
            } else {
                // access denied
            }
        }

        // Gallery permission
        PHPhotoLibrary.requestAuthorization({ (newStatus) in
            if newStatus ==  PHAuthorizationStatus.authorized {
                // access granted
                self.galleryPermission = true
            } else {
                // bool permanece false
            }
        })
    }

    func pickImage(_ viewController: UIViewController, _ callback: @escaping ((UIImage) -> Void )) {
            pickImageCallback = callback
            self.viewController = viewController

            alert.popoverPresentationController?.sourceView = self.viewController!.view

            viewController.present(alert, animated: true, completion: nil)
    }

    func openCamera() {
        if cameraPermission == true {
            alert.dismiss(animated: true, completion: nil)
            if UIImagePickerController .isSourceTypeAvailable(.camera) {
                picker.sourceType = .camera
                self.viewController!.present(picker, animated: true, completion: nil)
            } else {
                let alertController: UIAlertController = {
                    let controller = UIAlertController(title: "cameraWarning".localized(),
                                                       message: "cameraPermission".localized(),
                                                       preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default)
                    controller.addAction(action)
                    return controller
                }()
                viewController?.present(alertController, animated: true)
            }
        } else {
            // User trying to use the camera without giving permission
            let alert = UIAlertController(
                title: "cameraDenied".localized(),
                message: "cameraDeniedMessage".localized(),
                preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "cancel".localized(), style: .cancel, handler: nil))

            alert.addAction(UIAlertAction(title: "cameraSettings".localized(), style: .default, handler: { _ in
                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsURL)
                }
            }))
            viewController?.present(alert, animated: true)
        }
    }
    func openGallery() {
        if galleryPermission == true {
            alert.dismiss(animated: true, completion: nil)
            picker.sourceType = .photoLibrary
            self.viewController!.present(picker, animated: true, completion: nil)
        } else {
            // User trying to access the gallery without giving permission
            let alert = UIAlertController(
                title: "galleryDenied".localized(),
                message: "galleryDeniedMessage".localized(),
                preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "cancel".localized(), style: .cancel, handler: nil))

            alert.addAction(UIAlertAction(title: "cameraSettings".localized(), style: .default, handler: { _ in
                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsURL)
                }
            }))
            viewController?.present(alert, animated: true)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    // For Swift 4.2+
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        pickImageCallback?(image)
    }

    @objc func imagePickerController(_ picker: UIImagePickerController, pickedImage: UIImage?) {
    }

}
