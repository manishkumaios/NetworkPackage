//
//  WebIntegrator.swift
//  
//
//  Created by MANISH KUMAR on 1/25/22.
//

import Foundation
import Alamofire

//Concreate Implementation
public struct WebIntegrator: WebApiManaging {
    
    private let webapiDataSource: WebApiIntegrating
    
    public init (dataSource: WebApiIntegrating) {
        self.webapiDataSource = dataSource
    }
    
    public func fetch(url: URL, completion: @escaping ApiCallback) {
        self.manageApiRequest(url: url, completion: completion)
    }
    
    public func downloadImage(url: URL, completion: @escaping ApiCallback)  {
        self.manageImageDownload(url: url, completion: completion)
    }
}

private extension WebIntegrator {
    private func manageApiRequest(url: URL, completion: @escaping ApiCallback) {
        guard webapiDataSource.shouldUseOwnNetworkInterface else {
            self.fetchApiRequestWithAlmoFire(url: url, completion: completion)
            return
        }
        self.fetchInternalRequest(url: url, completion: completion)
    }
    private func fetchInternalRequest(url: URL, completion: @escaping ApiCallback) {
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
    
    private func fetchApiRequestWithAlmoFire (url: URL, completion: @escaping ApiCallback) {
        //AlmoFire
        let request = AF.request(url.absoluteString)
        request.responseData(completionHandler: { dataResponse in
            completion(dataResponse.data, dataResponse.response, dataResponse.error)
        })
    }
    
    //Image downloader
    private func manageImageDownload(url: URL, completion: @escaping ApiCallback) {
        guard !webapiDataSource.shouldUseExternalImageDownloader else {
            self.fetchInternalImageDownloadRequest(url: url, completion: completion)
            return
        }
        self.fetchInternalRequest(url: url, completion: completion)
        
    }
    
    //Own component
    private func fetchInternalImageDownloadRequest(url: URL, completion: @escaping ApiCallback) {
        let task = URLSession.shared.downloadTask(with: url) { filePath, response, error in
            guard let tempURL = filePath else {
                completion(nil, nil, error)
                return }
            let data = try? Data(contentsOf: tempURL, options: .alwaysMapped)
            completion(data, response, error)
        }
        task.resume()
    }
    
    //Kingfisher
    private func fetchExternalImageDownloadRequest(url: URL, completion: @escaping ApiCallback) {
        
    }
}

