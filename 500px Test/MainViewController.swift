//
//  ViewController.swift
//  500px Test
//
//  Created by Viswa Kodela on 2020-03-06.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import UIKit
import SDWebImage

class MainViewController: UIViewController {
    
    // MARK:- Properties
    static let popularPhotosApi = Router<PopularApi>()
    var photos = [Photo]()
    
    // MARK:- Layout objects
    var collectionView: UICollectionView! = nil
    
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        fetchData()
    }

    // MARK:- Helper Methods
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: generateLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(PhotoItemCell.self, forCellWithReuseIdentifier: PhotoItemCell.photoItemCellID)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func generateLayout() -> UICollectionViewCompositionalLayout {
        // Full
        let fullPhotoItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalWidth(2/3)))
        fullPhotoItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        // Main with pair
        let mainItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.7),
                heightDimension: .fractionalHeight(1)))
        mainItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let pairItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.5)))
        pairItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let rightGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.3),
                heightDimension: .fractionalHeight(1)),
            subitem: pairItem, count: 2)
        
        let mainWithPairGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(4/9)), subitems: [mainItem, rightGroup])
        
        
        
        // group
        let nestedGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(16/9)),
            subitems: [fullPhotoItem, mainWithPairGroup])
        
        // section
        let section = NSCollectionLayoutSection(group: nestedGroup)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func fetchData() {
        let parameters: Parameters = ["feature" : "popular",]
        MainViewController.popularPhotosApi.request(.getPhotos(featureType: parameters)) { (data, resp, err) in
            if let error = err {
                print("Error fetching popular photos with error \(error.localizedDescription)")
                return
            }
            guard let data = data else { return }
            do {
                let popularPhotos = try JSONDecoder().decode(PhotoStream.self, from: data)
                self.photos = popularPhotos.photos
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } catch {
                print("Decoding error.. \(error.localizedDescription)")
            }
        }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoItemCell.photoItemCellID, for: indexPath) as! PhotoItemCell
        return cell
    }
}
