//
//  LocationLabel.swift
//  500px Test
//
//  Created by Viswa Kodela on 2020-03-08.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import UIKit

class LocationLable: UIView {
    
    // MARK:- Layout objects
    let gpsImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(systemName: "mappin")
        iv.tintColor = .white
        return iv
    }()
    
    let countryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = true
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    lazy var overallStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [gpsImageView, countryLabel, UIView()])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 4
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    private func configureLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(overallStackView)
        overallStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        overallStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        overallStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
