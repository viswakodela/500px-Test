//
//  DetailsViewModel.swift
//  500px Test
//
//  Created by Viswa Kodela on 2020-03-08.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import UIKit

/// Protocol that represents the Data layer for DetailsController
protocol DetailsModelProtocol: class {
    init(photo: Photo)
    var photo: Photo { get }
}

extension DetailsModelProtocol {
    func fetchPhotDetails(completion: @escaping (PhotoDetail) -> Void) {
        MainViewController.popularPhotosApi.request(.getPhoto(withID: photo.id)) { (data, resp, err) in
            if let error = err {
                print(error.localizedDescription)
                // Respond to error
            }
            guard let data = data else {return}
            do {
                let photoDetail = try JSONDecoder().decode(PhotoDetail.self, from: data)
                completion(photoDetail)
            } catch {
                print("Error fetching Photo Details with error \(error.localizedDescription)")
                // Respond to error
            }
        }
    }
}

class DetailsHeaderModel: DetailsModelProtocol {
    var photo: Photo
    
    var photoId: Int {
        return photo.id
    }
    
    var userProfilePic: String {
        return photo.user?.userpic_url ?? "URL string not available"
    }
    
    var userName: String {
        return photo.user?.username ?? "No Name"
    }
    
    var userFullName: String {
        return photo.user?.fullname ?? "No fullname"
    }
    
    var featuredDate: String {
        return photo.featureDate.dateFromString.stringFromDate
    }
    
    var imageName: String {
        return photo.name
    }
    
    required init(photo: Photo) {
        self.photo = photo
    }
}
