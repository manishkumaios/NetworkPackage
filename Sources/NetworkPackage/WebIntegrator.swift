//
//  WebIntegrator.swift
//  
//
//  Created by MANISH KUMAR on 1/25/22.
//

import Foundation

public struct WebIntegrator: WebApiManaging {
    
    private let webapiDataSource: WebApiIntegrating
    
    public init (dataSource: WebApiIntegrating) {
        self.webapiDataSource = dataSource
    }
    
   public func fetch(url: URL, completion: @escaping ApiCallback) {
       self.manageApiRequest(url: url, completion: completion)
    }
}

private extension WebIntegrator {
    func manageApiRequest(url: URL, completion: @escaping ApiCallback) {
        guard webapiDataSource.shouldUseOwnNetworkInterface else {
            self.fetchApiRequestWithAlmoFire(url: url, completion: completion)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            //printing stuff
            #if DEBUG
            let string = String(decoding: data ?? Data(), as: UTF8.self)
            print(string)
            #endif
            completion(data, response ,error)
        }
        task.resume()
     }
    
    func fetchApiRequestWithAlmoFire (url: URL, completion: @escaping ApiCallback) {
        
    }
}

