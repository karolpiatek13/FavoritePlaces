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
            if indexPath.row != 0 || !(interactor?.isEditable ?? true) {
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
                cell.photo.isUserInteractionEnabled = true
                cell.photo.addGestureRecognizer(tapGestureRecognizer)
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 && interactor?.isEditable ?? false {
            interactor?.delegate?.showAvatarChangeOptions(picker: picker)
            return
        }
    }
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        guard let imageView = sender.view as? UIImageView else { return }
        UIView.animate(withDuration: Constants.animateDuration, animations: {
            let newImageView = UIImageView(image: imageView.image)
            newImageView.frame = self.getVisibleRect()
            newImageView.backgroundColor = .black
            newImageView.contentMode = .scaleAspectFit
            newImageView.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissFullscreenImage))
            newImageView.addGestureRecognizer(tap)
            self.interactor?.delegate?.view.addSubview(newImageView)
            self.interactor?.delegate?.navigationController?.setNavigationBarHidden(true, animated: false)
        })
        interactor?.delegate?.tableView.isScrollEnabled = false
    }
    
    func getVisibleRect() -> CGRect {
        var visibleRect = CGRect.zero
        guard let y = interactor?.delegate?.navigationController?.navigationBar.frame.height,
            let offSet = interactor?.delegate?.tableView.contentOffset,
            let viewSize = superview?.bounds.size else { return visibleRect }
        visibleRect.origin = offSet
        visibleRect.origin.y += y
        visibleRect.size = viewSize
        return visibleRect
    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        interactor?.delegate?.navigationController?.setNavigationBarHidden(false, animated: false)
        interactor?.delegate?.tableView.isScrollEnabled = true
        UIView.animate(withDuration: Constants.animateDuration, animations: {
        sender.view?.removeFromSuperview()
        })
    }
}

extension GalleryCell: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        guard let chosenImage = info[.originalImage] as? UIImage else {
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
