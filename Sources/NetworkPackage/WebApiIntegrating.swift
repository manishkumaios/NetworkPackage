//
//  WebApiIntegrating.swift
//  
//
//  Created by MANISH KUMAR on 1/25/22.
//

import Foundation

public protocol WebApiIntegrating {
    var shouldUseOwnNetworkInterface: Bool { get }
    var shouldUseExternalImageDownloader: Bool { get }
}

public typealias ApiCallback = ((Data?, URLResponse?, Error?) -> Void)
protocol WebApiManaging {
    func fetch(url: URL, params: [AnyHashable: Any]?, requestType: RequestType, completion: @escaping ApiCallback)
    func downloadImage(url: URL, params: [AnyHashable: Any]?, requestType: RequestType, completion: @escaping ApiCallback)
}
