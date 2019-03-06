//
//  ContactsFetcher.swift
//  Contacts
//
//  Created by RTC-HN360 on 2/13/19.
//  Copyright © 2019 Hypertech Team. All rights reserved.
//

import UIKit
import SwiftyJSON

class ContactsFetcher: BaseFetcher {
    
    private var accessToken:String? = nil
    
    public func doFetchContactsWithURL(success:@escaping (ContactsEntity?)->(), failure:@escaping (Error?)->()) {
        self.doFetchWithURL(url: self.fetchURL()) { (data, error) in
            if (error == nil) {
                let json = try? JSON(data: data!)
                let contactsEntity = ContactsEntity(json: json!)
//                let contactsEntity = try? JSONDecoder().decode(ContactsEntity.self, from: data!)
                if (contactsEntity != nil) {
                    success(contactsEntity)
                } else {
                    success(nil)
                }
            } else {
                failure(error)
            }
        }
    }
    
    init(accessToken:String) {
        let sessionConfiguration:URLSessionConfiguration = URLSessionConfiguration.ephemeral
        let formatToken:String = "Bearer +\(accessToken)"
        sessionConfiguration.httpAdditionalHeaders = ["Authorization" : formatToken, "GData-Version" : "3.0"]
        self.accessToken = accessToken
    }
    
    func fetchURL() -> String {
        return URLConstant().ContactsEndPointURLString + self.accessToken!
    }
}
