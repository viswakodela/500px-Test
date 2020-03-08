//
//  DetailsController.swift
//  500px Test
//
//  Created by Viswa Kodela on 2020-03-07.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import UIKit

/// This class is the base class to represent the Detailed content of the Image. I tried mimicing the actual UI in the `500px` app, but i don't have much time to implement as it is show in the real app. So i did what i could.]
class DetailsController: UICollectionViewController {
    
    // MARK:- Properties
    let photo: Photo
    let edgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    
    /// This property is represents the data underlies in all the cell's of the collectionView.
    /// I created this particularly to add the data for each cell in the collectionView. Each cell has its own view model but they all depends on the `DetailsModelProtocol` which basically depends on `Photo` object.
    /// You can ask me why i choose this way to represent the DetailsController.
    var dataSource = [DetailsModelProtocol]()
    
    // MARK:- Layout Objects
    lazy var navigationHeaderView: NavigationHeader = {
        let view = NavigationHeader(photo: photo)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = photo.name
        return view
    }()
    
    // MARK:- Init
    init(photo: Photo) {
        self.photo = photo
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        createDataSource()
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK:- Helper Methods
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
        collectionView.register(LikeAndLocationCell.self, forCellWithReuseIdentifier: LikeAndLocationCell.locationCellID)
        collectionView.register(ImageHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ImageHeaderView.imageHeaderID)
    }
    
    private func createDataSource() {
        let likesAndLocationModel = LikesAndLocationModel(photo: photo)
        self.dataSource.append(likesAndLocationModel)
        
        self.collectionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- UICollection View Delegate, DataSource and DelegateFlowLayout Methods
extension DetailsController: UICollectionViewDelegateFlowLayout {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LikeAndLocationCell.locationCellID, for: indexPath) as! LikeAndLocationCell
        let locationModel = LikesAndLocationModel(photo: photo)
        cell.populateCell(with: locationModel)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ImageHeaderView.imageHeaderID, for: indexPath) as! ImageHeaderView
        let detailsHeaderModel = DetailsHeaderModel(photo: photo)
        header.configureHeader(with: detailsHeaderModel)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 30, height: 150)
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
