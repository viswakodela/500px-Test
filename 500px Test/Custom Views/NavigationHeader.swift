//
//  NavigationHeader.swift
//  500px Test
//
//  Created by Viswa Kodela on 2020-03-08.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import UIKit

/// This class is used to mimic the regular navigationBar, we are using this in the `DetailsController`. We could do lot more with this class than i did in this project.
class NavigationHeader: UIView {
    
    // MARK:- Layout Object
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = .gray
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.text = "Test"
        return label
    }()
    
    lazy var overallStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [backButton,
                                                titleLabel,
                                                UIView()])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 1
        sv.alignment = .center
        sv.setCustomSpacing(30, after: backButton)
        return sv
    }()
    
    // MARK:- Init
    init(photo: Photo) {
        super.init(frame: .zero)
        configureLayout()
    }
    
    // MARK:- Helper Methods
    private func configureLayout() {
        backgroundColor = .systemBackground
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 1
        layer.shadowOpacity = 1
        
        addSubview(overallStackView)
        overallStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        overallStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        overallStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        overallStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
