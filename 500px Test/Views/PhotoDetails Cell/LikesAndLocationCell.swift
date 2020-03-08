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
    
    let viewsCountView: ViewCountView = {
        let view = ViewCountView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = "Views"
        return view
    }()
    
    let votesCountView: ViewCountView = {
        let view = ViewCountView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = "Votes"
        return view
    }()
    
    lazy var bottomStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [viewsCountView, votesCountView, UIView()])
        sv.translatesAutoresizingMaskIntoConstraints = true
        sv.axis = .horizontal
        sv.spacing = 50
        return sv
    }()
    
    lazy var overallStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [locationView, bottomStackView])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 40
        return sv
    }()

    
    // MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    // MARK:- Helper Methods
    private func configureLayout() {
        addSubview(overallStackView)
        overallStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        overallStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        overallStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        overallStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func populateCell(with detailModel: DetailsModelProtocol) {
        let detailModel = detailModel as! LikesAndLocationModel
        locationView.countryLabel.text = "\(detailModel.city), \(detailModel.country)"
        viewsCountView.countLabel.text = detailModel.views
        votesCountView.countLabel.text = detailModel.votes
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
