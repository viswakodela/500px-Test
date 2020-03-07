//
//  ViewController.swift
//  500px Test
//
//  Created by Viswa Kodela on 2020-03-06.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK:- Properties
    static let popularPhotosApi = Router<PopularApi>()
    
    
    // MARK:- Layout objects
    
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        fetchTestData()
    }

    // MARK:- Helper Methods
    private func configureLayout() {
        view.backgroundColor = .red
    }
    
    private func fetchTestData() {
        let parameters: Parameters = ["feature" : "popular",]
        MainViewController.popularPhotosApi.request(.getPhotos(featureType: parameters)) { (data, resp, err) in
            if let error = err {
                print("Erro fetching popular photos with error \(error.localizedDescription)")
                return
            }
            guard let data = data else { return }
            do {
                let popularPhotos = try JSONDecoder().decode(PhotoStream.self, from: data)
                print(popularPhotos)
            } catch {
                print("Decoding error.. \(error.localizedDescription)")
            }
        }
    }
}

