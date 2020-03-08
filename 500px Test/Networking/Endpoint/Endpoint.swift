//
//  Endpoint.swift
//  NetworkLayer using Protocol oriented Approach
//
//  Created by Viswa Kodela on 2020-01-20.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import Foundation

protocol EndPointType {
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}

extension EndPointType {
    var baseURL: URL {
        guard let baseUrl =  URL(string: "https://api.500px.com") else { fatalError() }
        return baseUrl
    }
    
    var headers: HTTPHeaders? {
        return [
                "Content-Type": "application/json",
                "consumer_key": Bundle.main.object(forInfoDictionaryKey: "CONSUMER_KEY") as! String]
    }
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public typealias Parameters = [String:Any]
public typealias HTTPHeaders = [String:String]

public enum HTTPTask {
    case request
    
    case requestParameters(bodyParameters: Parameters?, urlParameters: Parameters?)
    
    case requestParametersAndHeaders(bodyParameters: Parameters?, urlParameters: Parameters?, additionalHeaders: HTTPHeaders?)
    
    // case download, upload etc.
}
