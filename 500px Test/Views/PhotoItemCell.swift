//
//  PhotoItemCell.swift
//  500px Test
//
//  Created by Viswa Kodela on 2020-03-07.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import UIKit

/// Collection view cell that represents each item user will see in the `MainViewController`
class PhotoItemCell: UICollectionViewCell {
    
    // MARK:- Properties
    static let photoItemCellID = "photoItemCellID"
    var photo: Photo? {
        didSet {
            guard let photoUrl = photo?.imageUrls.first, let url = URL(string: photoUrl) else { return }
            photoImageView.sd_setImage(with: url, placeholderImage: nil)
            activitySpinner.stopAnimating()
            if let userPicString = photo?.user?.userpic_url, let url = URL(string: userPicString) {
                userImageView.sd_setImage(with: url)
                userNameLabel.text = photo?.user?.username
            }
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
    
    let userImageView: UIImageView = {
        let userIV = UIImageView()
        userIV.translatesAutoresizingMaskIntoConstraints = false
        userIV.contentMode = .scaleAspectFit
        userIV.clipsToBounds = true
        userIV.heightAnchor.constraint(equalToConstant: 25).isActive = true
        userIV.widthAnchor.constraint(equalToConstant: 25).isActive = true
        return userIV
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Viswa Kodela"
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = .white
        return label
    }()
    
    lazy var userInfoStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [userImageView, userNameLabel])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 10
        sv.alignment = .center
        return sv
    }()
    
    lazy var photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        iv.addSubview(userInfoStackView)
        userInfoStackView.leadingAnchor.constraint(equalTo: iv.leadingAnchor, constant: 6).isActive = true
        userInfoStackView.bottomAnchor.constraint(equalTo: iv.bottomAnchor, constant: -6).isActive = true
        userInfoStackView.trailingAnchor.constraint(equalTo: iv.trailingAnchor, constant: -6).isActive = true
        userInfoStackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return iv
    }()
    
    // MARK:- Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userImageView.layer.cornerRadius = userImageView.bounds.height / 2
    }
    
    private func configureCell() {
        
        addSubview(activitySpinner)
        activitySpinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activitySpinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(photoImageView)
        photoImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
