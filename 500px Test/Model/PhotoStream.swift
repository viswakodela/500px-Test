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




