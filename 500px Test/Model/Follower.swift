//
//  Follower.swift
//  500px Test
//
//  Created by Viswa Kodela on 2020-03-08.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import Foundation

struct Follower: Decodable {
    let currentPage: Int
    let followers: [User]
    
    private enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case followers
    }
}
