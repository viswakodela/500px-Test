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
    
    // MARK:- Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    private func configureCell() {
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
