//
//  Constant.swift
//  Contacts
//
//  Created by RTC-HN360 on 2/1/19.
//  Copyright © 2019 Hypertech Team. All rights reserved.
//

import UIKit

class Constant: NSObject {
    // Google constants
    let Scope = "https://www.googleapis.com/auth/contacts.readonly"
    let ContactsEndPointURLString = "https://www.google.com/m8/feeds/contacts/default/thin?max-results=10000"
    let ClientId = "554746142537-6h6qacj72v8qk3qr59gchmid8la9b2si.apps.googleusercontent.com"
    
    let UserAccessToken = "UserAccessToken"
    
    let getContactsInfoNotification = "getContactsInfoNotification"
    let userInforKey = "userInforKey"
}
