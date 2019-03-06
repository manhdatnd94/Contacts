//
//  ContactsEntity.swift
//  Contacts
//
//  Created by RTC-HN360 on 2/15/19.
//  Copyright © 2019 Hypertech Team. All rights reserved.
//

import UIKit
import SwiftyJSON

class ContactsEntity: NSObject {
    var feed:ContactsEntityFeed?
    var version:String?
    var encoding:String?
    
    init(json: JSON) {
        self.version = json["version"].string
        self.encoding = json["encoding"].string
        self.feed = ContactsEntityFeed(json: json)
    }
}

class ContactsEntityFeed: NSObject {
    var entry:Array<ContactsEntityFeedEntry>?
    
    init(json: JSON) {
        self.entry = Array<ContactsEntityFeedEntry>.init()
        for entryJSON in json["feed"]["entry"].arrayValue {
            let entryEntity = ContactsEntityFeedEntry(json: entryJSON)
            self.entry?.append(entryEntity)
        }
    }
    
}

class ContactsEntityFeedEntry: NSObject {
    var id:ContactsEntityFeedEntryItemId?
    var updated:ContactsEntityFeedEntryItemUpdated?
    var title:ContactsEntityFeedEntryItemTitle?
    var gdEmail:Array<ContactsEntityFeedEntryItemGdEmail>?
    var gdPhoneNumber:Array<ContactsEntityFeedEntryItemGdPhoneNumber>?
    
    init(json:JSON) {
        self.id = ContactsEntityFeedEntryItemId(json: json)
        self.updated = ContactsEntityFeedEntryItemUpdated(json: json)
        self.title = ContactsEntityFeedEntryItemTitle(json: json)
        self.gdEmail = Array<ContactsEntityFeedEntryItemGdEmail>.init()
        self.gdPhoneNumber = Array<ContactsEntityFeedEntryItemGdPhoneNumber>.init()
        
        for gdEmailJSON in json["gd$email"].arrayValue {
            let entryGdEmailEntity = ContactsEntityFeedEntryItemGdEmail(json: gdEmailJSON)
            self.gdEmail?.append(entryGdEmailEntity)
        }
        
        for gdPhoneNumberJSON in json["gd$phoneNumber"].arrayValue {
            let entryGdPhoneNumnberEntity = ContactsEntityFeedEntryItemGdPhoneNumber(json: gdPhoneNumberJSON)
            self.gdPhoneNumber?.append(entryGdPhoneNumnberEntity)
        }
    }
    
}

class ContactsEntityFeedEntryItemId: NSObject {
    var t:String?
    
    init(json: JSON) {
        self.t = json["id"]["$t"].stringValue
    }
}

class ContactsEntityFeedEntryItemUpdated: NSObject {
    var t:String?
    
    init(json: JSON) {
        self.t = json["updated"]["$t"].stringValue
    }
}

class ContactsEntityFeedEntryItemTitle: NSObject {
    var t:String?
    var type:String?

//    private enum CodingKeys: String, CodingKey {
//        case t = "$t"
//        case type
//    }
    
    init(json: JSON) {
        self.t = json["title"]["$t"].stringValue
        self.type = json["title"]["type"].stringValue
    }
}

class ContactsEntityFeedEntryItemGdEmail: NSObject {
    var address:String?
    
    init(json: JSON) {
        self.address = json["address"].stringValue
    }
}

class ContactsEntityFeedEntryItemGdPhoneNumber: NSObject {
    var t:String?
    
    init(json: JSON) {
        self.t = json["$t"].stringValue
    }
}


