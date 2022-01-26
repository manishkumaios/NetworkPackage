//
//  WebApiIntegrating.swift
//  
//
//  Created by MANISH KUMAR on 1/25/22.
//

import Foundation

public protocol WebApiIntegrating {
    var shouldUseOwnNetworkInterface: Bool { get }
}

public typealias ApiCallback = ((Data?, URLResponse?, Error?) -> Void)
protocol WebApiManaging {
    func fetch(url: URL, completion: @escaping ApiCallback)
    func downloadImage(url: URL, completion: @escaping ApiCallback)
}
