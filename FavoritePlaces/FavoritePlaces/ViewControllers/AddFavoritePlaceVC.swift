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
        self.hideKeyboardWhenTappedAround()
        navigationController?.title = "AddFavoritePlace.NavBar.Title".localized
    }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.getNumberOfVisibleCells()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellInteractor = interactor.getCellInteractor(for: indexPath.row) else {
            return UITableViewCell()
        }
        let cellView = tableView.getReusableCellSafe(cellType: cellInteractor.cellType)
        cellInteractor.configure(cellView)
        if let cell = cellView as? DescriptionCell {
            cell.textView.delegate = self
        }
        if let interactor = cellInteractor as? GalleryCellInteractor {
            interactor.delegate = self
        }
        return cellView
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch interactor.getCellEnum(index: indexPath.row) {
        case .mainPhoto:
            showAvatarChangeOptions(picker: picker)
        default:
            break
        }
    }
    
    func showAvatarChangeOptions(picker: UIImagePickerController) {
        let alert = UIAlertController(title: "Permissions.Alert.Title".localized, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Permissions.Alert.Camera".localized, style: .default, handler: { action in
            AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
                if response {
                    if UIImagePickerController.isSourceTypeAvailable(.camera) {
                        if UIImagePickerController.isSourceTypeAvailable(.camera) {
                            picker.sourceType = .camera
                            picker.allowsEditing = false
                            picker.cameraCaptureMode = .photo
                            self.present(picker, animated: true, completion: nil)
                        }
                    }
                } else {
                    let failureAlertController = UIAlertController(title: "Permissions.Error.Title".localized, message: "Permissions.Error.Message".localized, preferredStyle: .alert)
                    self.present(failureAlertController, animated: true)
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "Permissions.Alert.PhotoLibrary".localized, style: .default, handler: { action in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                picker.sourceType = .photoLibrary
                picker.allowsEditing = false
                picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
                self.present(picker, animated: true, completion: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: "Permissions.Alert.Cancel".localized, style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        present(alert, animated: true)
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
        let currentOffset = tableView.contentOffset
        UIView.setAnimationsEnabled(false)
        tableView.beginUpdates()
        tableView.endUpdates()
        UIView.setAnimationsEnabled(true)
        tableView.setContentOffset(currentOffset, animated: false)
    }
}
