//
//  LikesAndLocationCell.swift
//  500px Test
//
//  Created by Viswa Kodela on 2020-03-08.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import UIKit

class LikeAndLocationCell: UICollectionViewCell {
    
    // MARK:- Layout Object
    let locationView = LocationLable()
    static let locationCellID = "locationCellID"
    
    
    // MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    // MARK:- Helper Methods
    private func configureLayout() {
        addSubview(locationView)
        locationView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        locationView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        locationView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        locationView.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func populateCell(with detailModel: DetailsModelProtocol) {
        let detailModel = detailModel as! LikesAndLocationModel
        locationView.countryLabel.text = "\(detailModel.city), \(detailModel.country)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
