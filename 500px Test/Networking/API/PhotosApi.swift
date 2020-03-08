//
//  PopularApi.swift
//  500px Test
//
//  Created by Viswa Kodela on 2020-03-06.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import Foundation

enum PhotoStreamApi {
    case getPhotos(featureType: Parameters)
    case getPhoto(withID: Int)
}

extension PhotoStreamApi: EndPointType {
    var baseURL: URL {
        guard let baseUrl =  URL(string: "https://api.500px.com") else { fatalError() }
        return baseUrl
    }

    var path: String {
        switch self {
        case .getPhotos(_):
            return "/v1/photos/"
        case .getPhoto(let withID):
            return "/v1/photos/\(withID)"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .getPhotos(_):
            return .get
        case .getPhoto(_):
            return .get
        }
    }

    var task: HTTPTask {
        switch self {
        case .getPhotos(let featureType):
            return .requestParametersAndHeaders(bodyParameters: nil, urlParameters: featureType, additionalHeaders: headers)
        case .getPhoto(_):
            return .requestParametersAndHeaders(bodyParameters: nil, urlParameters: nil, additionalHeaders: headers)
        }
    }
}
