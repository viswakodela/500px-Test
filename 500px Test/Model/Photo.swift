//
//  Photo.swift
//  500px Test
//
//  Created by Viswa Kodela on 2020-03-07.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import Foundation

struct Photo: Decodable {
    let id                      : Int
    let userID                  : Int?
    let createdDate             : String
    let featureDate             : String
    let takenAt                 : String?
    let description             : String
    let imageUrls               : [String]
    let numberOfVotes           : Int
    let numberOfViews           : Int
    let numberOfComments        : Int
    let url                     : String
    let height                  : Int
    let user                    : User?
    let images                  : [Images]?
    let name                    : String
    
    private enum CodingKeys: String, CodingKey {
        case id, description, url, height, user, images, name, userID
        case createdDate        = "created_at"
        case featureDate        = "feature_date"
        case takenAt            = "taken_at"
        case imageUrls          = "image_url"
        case numberOfVotes      = "votes_count"
        case numberOfViews      = "times_viewed"
        case numberOfComments   = "comments_count"
    }
}

struct PhotoDetail: Decodable {
    let photo: Photo
}

struct Images: Decodable {
    let size                    : Int
    let url                     : String
    let https_url               : String
}
