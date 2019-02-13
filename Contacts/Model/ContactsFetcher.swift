//
//  ContactsFetcher.swift
//  Contacts
//
//  Created by RTC-HN360 on 2/13/19.
//  Copyright © 2019 Hypertech Team. All rights reserved.
//

import UIKit

class ContactsFetcher: BaseFetcher {
    public func doFetchContactsWithURL(success:(HTTPURLResponse?,NSData?)->(), failure:(HTTPURLResponse?,NSError?)->()) {
        self.doFetchWithURL(url: self.fetchURL()) { (data, response, error) in
            
        }
    }
    
    func fetchURL() -> NSURL {
        let url:NSURL = NSURL(string: URLConstant().ContactsEndPointURLString)!
        return url
    }
}
