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
    
    /// CurrentPage helps to paginate the data
    var currentPage: Int = 1
    
    /// TotalPages helps to limt fetching new content when we reach to the end.
    var totalPages: Int = 0
    
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
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1)))
        mainItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let pairItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.5)))
        pairItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let pairGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1)),
            subitem: pairItem, count: 2)
        
        let mainWithPairGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalWidth(6/9)),
            subitems: [mainItem, pairGroup])
        
        // Triplet
        let tripletItem = NSCollectionLayoutItem(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/3),
            heightDimension: .fractionalHeight(1.0)))
        tripletItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

        let tripletGroup = NSCollectionLayoutGroup.horizontal(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(4/9)),
          subitems: [tripletItem, tripletItem, tripletItem])

        // Reversed main with pair
        let mainWithPairReversedGroup = NSCollectionLayoutGroup.horizontal(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(4/9)),
          subitems: [pairGroup, mainItem])
        
        // nest groups
        let nestedGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(16/9)),
            subitems: [fullPhotoItem, mainWithPairGroup, tripletGroup, mainWithPairReversedGroup])
        
        // section
        let section = NSCollectionLayoutSection(group: nestedGroup)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func fetchData() {
        let parameters: Parameters = ["feature" : "popular", "page": currentPage]
        MainViewController.popularPhotosApi.request(.getPhotos(featureType: parameters)) { (data, resp, err) in
            if let error = err {
                print("Error fetching popular photos with error \(error.localizedDescription)")
                return
            }
            guard let data = data else { return }
            do {
                let popularPhotos = try JSONDecoder().decode(PhotoStream.self, from: data)
                self.currentPage = popularPhotos.currentPage
                self.totalPages = popularPhotos.totalPages
                self.photos += popularPhotos.photos
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } catch {
                print("Decoding error.. \(error.localizedDescription)")
            }
        }
    }
}

// MARK:- UICollectionView Delegate and DataSource Methods
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoItemCell.photoItemCellID, for: indexPath) as! PhotoItemCell
        cell.photo = photos[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // pre fetch new data
        if indexPath.item == photos.count - 30 {
            print("Start paginating")
            self.currentPage += 1
            if currentPage <= totalPages { // stop fetching new data once we reach to the end.
                self.fetchData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
