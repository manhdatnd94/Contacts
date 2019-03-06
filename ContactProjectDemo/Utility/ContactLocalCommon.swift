//
//  ContactLocalCommon.swift
//  ContactProjectDemo
//
//  Created by RTC-HN360 on 3/6/19.
//  Copyright © 2019 Hypertech Team. All rights reserved.
//

import UIKit
import ContactsUI

enum ContactsFilter {
    case none
    case mail
    case message
}

class ContactLocalCommon: NSObject {
    class func getContacts(filter: ContactsFilter = .none) -> [ContactLocalEntity] {
        //Init contact store
        let contactStore = CNContactStore()
        let keysToFetch = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactPhoneNumbersKey,
            CNContactEmailAddressesKey,
            CNContactThumbnailImageDataKey] as [Any]
        
        var allContainers: [CNContainer] = []
        do {
            allContainers = try contactStore.containers(matching: nil)
        } catch {
            print("Error fetching containers") // you can use print()
        }
        
        var allContacts: [CNContact] = []
        
        for container in allContainers {
            let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)
            
            do {
                let containerResults = try contactStore.unifiedContacts(matching: fetchPredicate, keysToFetch: keysToFetch as! [CNKeyDescriptor])
                allContacts.append(contentsOf: containerResults)
            } catch {
                print("Error fetching containers")
            }
        }
        
        var results = [ContactLocalEntity]()
        
        for contact in allContacts {
            results.append(ContactLocalEntity(contact: contact))
        }
        
        return results
    }
}
