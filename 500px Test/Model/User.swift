//
//  User.swift
//  500px Test
//
//  Created by Viswa Kodela on 2020-03-07.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import Foundation

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
