//
//  ViewCountView.swift
//  500px Test
//
//  Created by Viswa Kodela on 2020-03-08.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import UIKit

class ViewCountView: UIView {
    
    // MARK:- Layout Objects
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Views"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    let countLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 25, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    lazy var overallStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [titleLabel, countLabel, UIView()])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 3
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    private func configureLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(overallStackView)
        overallStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        overallStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        overallStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
