//
//  AddFavoritePlaceVC.swift
//  FavoritePlaces
//
//  Created by Karol on 02.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit
import AVKit

class AddFavoritePlaceVC: UITableViewController {
    
    fileprivate let picker = UIImagePickerController()
    var interactor: BaseTableInteractorProtocol = AddFavoritePlaceInteractor()
    
    override func viewDidLoad() {
        picker.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 128
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.getNumberOfVisibleCells()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellInteractor = interactor.getCellInteractor(for: indexPath.row) else {
            return UITableViewCell()
        }
        let cellView = tableView.getReusableCellSafe(cellType: cellInteractor.cellType)
        if let cell = cellView as? DescriptionCell {
            cell.textView.delegate = self
        }
        cellInteractor.configure(cellView)
        return cellView
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch interactor.getCellEnum(index: indexPath.row) {
        case .mainPhoto:
            showAvatarChangeOptions()
        default:
            break
        }
    }
    
    private func showAvatarChangeOptions() {
        let alert = UIAlertController(title: "Permissions.Alert.Title".localized, message: "Permissions.Alert.Message".localized, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Permissions.Alert.Camera", style: .default, handler: openCamera))
        alert.addAction(UIAlertAction(title: "Permissions.Alert.PhotoLibrary", style: .default, handler: openPhotoLibrary))
        alert.addAction(UIAlertAction(title: "Permissions.Alert.Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        present(alert, animated: true)
    }
    
    func openPhotoLibrary(alert: UIAlertAction) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            picker.sourceType = .photoLibrary
            picker.allowsEditing = false
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            present(picker, animated: true, completion: nil)
        }
    }
    
    func openCamera(alert: UIAlertAction) {
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
            if response {
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    if UIImagePickerController.isSourceTypeAvailable(.camera) {
                        self.picker.sourceType = .camera
                        self.picker.allowsEditing = false
                        self.picker.cameraCaptureMode = .photo
                        self.present(self.picker, animated: true, completion: nil)
                    }
                }
            } else {
                let failureAlertController = UIAlertController(title: "Permissions.Error.Title", message: "Permissions.Error.Message", preferredStyle: .alert)
                self.present(failureAlertController, animated: true)
            }
        }
    }
}


extension AddFavoritePlaceVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            picker.dismiss(animated: true, completion: nil)
            return
        }
        guard let cellInteractor = interactor.getCellInteractor(for: 0) as? MainPhotoCellInteractor else { return }
        cellInteractor.mainPhoto = chosenImage
        tableView.reloadData()
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension AddFavoritePlaceVC: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        let currentOffset = tableView.contentOffset //
        UIView.setAnimationsEnabled(false) //
        tableView.beginUpdates()
        tableView.endUpdates()
        UIView.setAnimationsEnabled(true) //
        tableView.setContentOffset(currentOffset, animated: false) //
    }
}
