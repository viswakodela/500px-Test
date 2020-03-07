//
//  ParameterEncoder.swift
//  NetworkLayer using Protocol oriented Approach
//
//  Created by Viswa Kodela on 2020-01-20.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import Foundation

public protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}


public enum NetworkError: String, Error {
    case parametersNil = "Parameters were nil"
    case encodingFailed = "Parameter Encoding Filed"
    case missingURL = "URL is missing"
}
