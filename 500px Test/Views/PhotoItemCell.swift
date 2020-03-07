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
    
    // MARK:- Layout Objects
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
        backgroundColor = .red
        addSubview(photoImageView)
        photoImageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
