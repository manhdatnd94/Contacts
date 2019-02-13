//
//  BaseFetcher.swift
//  Contacts
//
//  Created by RTC-HN360 on 2/1/19.
//  Copyright © 2019 Hypertech Team. All rights reserved.
//

import UIKit

public class BaseFetcher: NSObject {
    
    private var session:URLSession
    private var accessToken:String? = nil
    
    public override init() {
        let sessionConfiguration:URLSessionConfiguration = URLSessionConfiguration.ephemeral
        self.session = URLSession.init(configuration: sessionConfiguration)
    }
    
    init(accessToken:String) {
        let sessionConfiguration:URLSessionConfiguration = URLSessionConfiguration.ephemeral
        let formatToken:String = "Bearer +\(accessToken)"
        sessionConfiguration.httpAdditionalHeaders = ["Authorization" : formatToken, "GData-Version" : "3.0"]
        self.accessToken = accessToken
        self.session = URLSession.init(configuration: sessionConfiguration)
    }
    
    public func doFetchWithURL(url: NSURL, completion: @escaping (NSData?, HTTPURLResponse?, NSError?) -> ()) {
        let dataTask: URLSessionDataTask = self.session.dataTask(with: url as URL) { (data, response, error) in
            let httpResponse:HTTPURLResponse = response as! HTTPURLResponse
            DispatchQueue.main.async(execute: { ()-> (Void) in
                completion(data as NSData?, httpResponse, error as NSError?)
            })
            
        }
        dataTask.resume()
    }
}
