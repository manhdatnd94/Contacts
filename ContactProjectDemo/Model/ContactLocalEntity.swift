//
//  ContactLocalEntity.swift
//  ContactProjectDemo
//
//  Created by RTC-HN360 on 3/6/19.
//  Copyright © 2019 Hypertech Team. All rights reserved.
//

import UIKit
import ContactsUI

class ContactLocalEntity: NSObject {
    var fullName: String?
    var phoneNumber: [String] = [String]()
    var email: [String] = [String]()
    
    init(contact: CNContact) {
        super.init()
        self.fullName = contact.givenName + contact.familyName
        for phone in contact.phoneNumbers {
            self.phoneNumber.append(phone.value.stringValue)
        }
        for email in contact.emailAddresses {
            self.email.append(email.value as String)
        }
    }
}
