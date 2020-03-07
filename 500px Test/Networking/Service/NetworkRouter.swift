//
//  NetworkRouter.swift
//  NetworkLayer using Protocol oriented Approach
//
//  Created by Viswa Kodela on 2020-01-20.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol NetworkRouter: class {
    associatedtype Endpoint: EndPointType
    func request(_ route: Endpoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}
