//
//  BaseFetcher.swift
//  Contacts
//
//  Created by RTC-HN360 on 2/1/19.
//  Copyright © 2019 Hypertech Team. All rights reserved.
//

import UIKit
import Alamofire

public class BaseFetcher: NSObject {
    
    private var session:URLSession
    
    public override init() {
        let sessionConfiguration:URLSessionConfiguration = URLSessionConfiguration.ephemeral
        self.session = URLSession.init(configuration: sessionConfiguration)
    }
    
    public func doFetchWithURL(url: String, completion: @escaping (Data?, Error?) -> ()) {
        Alamofire.request(url).responseData { response in
            if let error = response.error {
                completion(nil, error)
            } else {
                completion(response.data, nil)
            }
        }
    }
}
