//
//  DetailsViewModel.swift
//  500px Test
//
//  Created by Viswa Kodela on 2020-03-08.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import UIKit

protocol DetailsModelProtocol: class {
    init(photo: Photo)
}

class DetailsHeaderModel: DetailsModelProtocol {
    
    let photo: Photo
    
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
