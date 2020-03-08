//
//  UserApi.swift
//  500px Test
//
//  Created by Viswa Kodela on 2020-03-08.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import Foundation

enum UserApi {
    case getUser(withId: Int)
}

extension UserApi: EndPointType {
    
    var path: String {
        switch self {
            case .getUser(let withId):
            return "/v1/users/\(withId)/followers"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
            case .getUser(_):
                return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
            case .getUser(_):
                return .requestParametersAndHeaders(bodyParameters: nil, urlParameters: nil, additionalHeaders: headers)
        }
    }
}
