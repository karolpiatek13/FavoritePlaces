//
//  GalleryCell.swift
//  FavoritePlaces
//
//  Created by Karol on 05.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit
import AVKit

class GalleryCell: UITableViewCell {

    @IBOutlet weak var galleryCollectionView: UICollectionView!
    @IBOutlet weak var galleryTitleLabel: UILabel!
    
    fileprivate let picker = UIImagePickerController()
    
    var interactor: GalleryCellInteractor?
    
    func configure(interactor: GalleryCellInteractor, gallery: [UIImage]) {
        self.interactor = interactor
        picker.delegate = self
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        galleryCollectionView.register(UINib(nibName: PhotoCell.typeName, bundle: nil), forCellWithReuseIdentifier: PhotoCell.typeName)
    }
}

extension GalleryCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interactor?.gallery.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.typeName, for: indexPath) as? PhotoCell {
            cell.photo.image = interactor?.gallery[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            interactor?.delegate?.showAvatarChangeOptions(picker: picker)
        }
    }
}

extension GalleryCell: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            picker.dismiss(animated: true, completion: nil)
            return
        }
        interactor?.gallery.append(chosenImage)
        galleryCollectionView.reloadData()
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
