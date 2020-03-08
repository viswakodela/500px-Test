//
//  LikesAndLocationModel.swift
//  500px Test
//
//  Created by Viswa Kodela on 2020-03-08.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import Foundation

/// This class is a view model for the First cell which is `LikesAndLocationCell`.
class LikesAndLocationModel: DetailsModelProtocol {
    
    let photo: Photo
    
    var userId: Int {
        return photo.user?.id ?? 0
    }
    
    var city: String {
        return photo.user?.city ?? ""
    }
    
    var country: String {
        return photo.user?.country ?? ""
    }
    
    var views: String {
        return photo.numberOfViews.giveMeCorrectFormat
    }
    
    var votes: String {
        return photo.numberOfVotes.giveMeCorrectFormat
    }
    
    required init(photo: Photo) {
        self.photo = photo
    }
}
