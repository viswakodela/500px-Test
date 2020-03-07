//
//  PhotoItemCell.swift
//  500px Test
//
//  Created by Viswa Kodela on 2020-03-07.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import UIKit

class PhotoItemCell: UICollectionViewCell {
    
    // MARK:- Properties
    static let photoItemCellID = "photoItemCellID"
    var photo: Photo? {
        didSet {
            guard let photoUrl = photo?.imageUrls.first, let url = URL(string: photoUrl) else { return }
            photoImageView.sd_setImage(with: url, placeholderImage: nil)
            activitySpinner.stopAnimating()
        }
    }
    
    // MARK:- Layout Objects
    let activitySpinner: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    // MARK:- Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    private func configureCell() {
        addSubview(photoImageView)
        photoImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        addSubview(activitySpinner)
        activitySpinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activitySpinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
