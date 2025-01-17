//
//  ImageHeaderView.swift
//  500px Test
//
//  Created by Viswa Kodela on 2020-03-07.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import UIKit

/// UICollectionView's Header that holds the `HD Image` of the requested image.
class ImageHeaderView: UICollectionReusableView {
    
    // MARK:- Properties
    static let imageHeaderID = "imageHeaderID"
    
    // MARK:- Layout Object
    let imageWithSpinnerView: ImageWithSpinner = {
        let iws = ImageWithSpinner(frame: .zero)
        iws.translatesAutoresizingMaskIntoConstraints = false
        return iws
    }()
    
    let imageNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.text = "Viswa Kodela"
        label.numberOfLines = 1
        label.textColor = .white
        return label
    }()
    
    let userImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let moreDetailsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "More deaslcbslibvs iuabfbsiub iufhabsub uh ug 7 dusagifub 7bujdb8g uvu"
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    let seperaterLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var userNameDetailsStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [imageNameLabel, moreDetailsLabel])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 2
        return sv
    }()
    
    lazy var overallUserDetailsStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [userNameDetailsStackView, UIView(), userImageView])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 4
        sv.alignment = .center
        
        userImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        userImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        userImageView.layer.cornerRadius = 25
        return sv
    }()
    
    lazy var overallStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [imageWithSpinnerView, overallUserDetailsStackView, seperaterLine, UIView()])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 10
        seperaterLine.heightAnchor.constraint(equalToConstant: 2).isActive = true
        imageWithSpinnerView.heightAnchor.constraint(equalTo: sv.heightAnchor, multiplier: 0.8).isActive = true
        return sv
    }()
    
    // MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configurelayout()
    }
    
    // MARK:- Helper Methods
    private func configurelayout() {
        addSubview(overallStackView)
        overallStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        overallStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        overallStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        overallStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func configureHeader(with detailHeaderModel: DetailsModelProtocol) {
        let detailModel = detailHeaderModel as! DetailsHeaderModel
        guard let userProfileURL = URL(string: detailModel.userProfilePic) else {return}
        userImageView.sd_setImage(with: userProfileURL)
        moreDetailsLabel.text = "by \(detailModel.userFullName) • \(detailModel.featuredDate)"
        fetchHDImage(with: detailModel)
    }
    
    func fetchHDImage(with detailModel: DetailsHeaderModel) {
        imageNameLabel.text = detailModel.imageName
        detailModel.fetchPhotDetails { (photoDetail) in
            DispatchQueue.main.async {
                guard let imageUrlString = photoDetail.photo.imageUrls.first, let url = URL(string: imageUrlString) else { return }
                self.imageWithSpinnerView.photoImageView.sd_setImage(with: url)
                self.imageWithSpinnerView.activitySpinner.stopAnimating()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
