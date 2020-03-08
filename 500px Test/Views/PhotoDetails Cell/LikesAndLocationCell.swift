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
    static let userApi = Router<UserApi>()
    let locationView = ImageWithLabelView()
    static let locationCellID = "locationCellID"
    
    let viewsCountView: ViewCountView = {
        let view = ViewCountView()
        view.titleLabel.text = "Views"
        return view
    }()
    
    let votesCountView: ViewCountView = {
        let view = ViewCountView()
        view.titleLabel.text = "Votes"
        return view
    }()
    
    let followersCountView: ViewCountView = {
        let view = ViewCountView()
        view.titleLabel.text = "Followers"
        return view
    }()
    
    lazy var bottomStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [viewsCountView,
                                                votesCountView,
                                                followersCountView,
                                                ])
        sv.translatesAutoresizingMaskIntoConstraints = true
        sv.axis = .horizontal
        sv.spacing = 30
        sv.distribution = .fillEqually
        return sv
    }()
    
    lazy var overallStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [locationView,
                                                bottomStackView,])
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
        fetchFollowersData(detailModel: detailModel)
    }
    
    private func fetchFollowersData(detailModel: LikesAndLocationModel) {
        LikeAndLocationCell.userApi.request(.getUser(withId: detailModel.userId)) { (data, resp, err) in
            guard let data = data else { return }
            do {
                let followers = try JSONDecoder().decode(Follower.self, from: data)
                DispatchQueue.main.async {
                    self.followersCountView.countLabel.text = "\(followers.followers.count)"
                }
            } catch {
                print("Error fetching followers count with error \(error.localizedDescription)")
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
