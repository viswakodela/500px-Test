//
//  DetailsController.swift
//  500px Test
//
//  Created by Viswa Kodela on 2020-03-07.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import UIKit

class DetailsController: UICollectionViewController {
    
    let photo: Photo
    let edgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    var dataSource = [Int]()
    
    // MARK:- Layout Objects
    lazy var navigationHeaderView: NavigationHeader = {
        let view = NavigationHeader(photo: photo)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = photo.name
        return view
    }()
    
    init(photo: Photo) {
        self.photo = photo
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configureLayout() {
        view.addSubview(navigationHeaderView)
        navigationHeaderView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        navigationHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        navigationHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        navigationHeaderView.heightAnchor.constraint(equalToConstant: 84).isActive = true
    }
    
    private func configureCollectionView() {
        view.backgroundColor = .black
        collectionView.contentInset = edgeInsets
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "dummyCell")
        collectionView.register(ImageHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ImageHeaderView.imageHeaderID)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension DetailsController: UICollectionViewDelegateFlowLayout {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        80
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dummyCell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ImageHeaderView.imageHeaderID, for: indexPath) as! ImageHeaderView
        let detailsHeaderModel = DetailsHeaderModel(photo: photo)
        header.configureHeader(with: detailsHeaderModel)
//        header.configureHeader(with: photo, and: photo.user)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 200)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.3) {
            if scrollView.contentOffset.y < 0 {
                self.navigationHeaderView.alpha = 0
            } else {
                self.navigationHeaderView.alpha = 1
            }
        }
    }
}
