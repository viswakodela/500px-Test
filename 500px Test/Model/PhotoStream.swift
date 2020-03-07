//
//  PhotoStream.swift
//  500px Test
//
//  Created by Viswa Kodela on 2020-03-06.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import Foundation

struct PhotoStream: Decodable {
    let currentPage             : Int
    let feature                 : String
    let totalItems              : Int
    let totalPages              : Int
    let photos                  : [Photo]
    
    private enum CodingKeys: String, CodingKey {
        case currentPage        = "current_page"
        case totalItems         = "total_items"
        case totalPages         = "total_pages"
        case feature, photos
    }
}

struct Photo: Decodable {
    let id                      : Int
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
    
    private enum CodingKeys: String, CodingKey {
        case id, description, url, height, user
        case createdDate        = "created_at"
        case featureDate        = "feature_date"
        case takenAt            = "taken_at"
        case imageUrls          = "image_url"
        case numberOfVotes      = "votes_count"
        case numberOfViews      = "times_viewed"
        case numberOfComments   = "comments_count"
    }
}

struct User: Decodable {
    let id                      : Int
    let username                : String?
    let firstname               : String?
    let lastname                : String?
    let city                    : String?
    let country                 : String?
    let fullname                : String?
    let userpic_url             : String?
}

