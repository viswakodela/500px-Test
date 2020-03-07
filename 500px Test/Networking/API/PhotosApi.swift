//
//  PopularApi.swift
//  500px Test
//
//  Created by Viswa Kodela on 2020-03-06.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import Foundation

enum PopularApi {
    case getPhotos(featureType: Parameters)
}

extension PopularApi: EndPointType {
    var baseURL: URL {
        guard let baseUrl =  URL(string: "https://api.500px.com") else { fatalError() }
        return baseUrl
    }

    var path: String {
        switch self {
        case .getPhotos(_):
            return "/v1/photos/"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .getPhotos(_):
            return .get
        }
    }

    var task: HTTPTask {
        switch self {
        case .getPhotos(let featureType):
            return .requestParametersAndHeaders(bodyParameters: nil, urlParameters: featureType, additionalHeaders: headers)
        }
    }
}
