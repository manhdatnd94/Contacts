//
//  ContactCommon.swift
//  Contacts
//
//  Created by RTC-HN360 on 2/15/19.
//  Copyright © 2019 Hypertech Team. All rights reserved.
//

import UIKit

class ContactCommon: NSObject, GIDSignInDelegate {
    
    private var contactsFetcher : ContactsFetcher!
    private var accessToken : String?
    
    override init() {
        super.init()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().clientID = Constant().ClientId
        GIDSignIn.sharedInstance().scopes = ["https://www.google.com/m8/feeds","https://www.googleapis.com/auth/contacts.readonly"];
        
        let token = UserDefaults.standard.string(forKey: Constant().UserAccessToken)
        if(token != nil) {
            GIDSignIn.sharedInstance()?.signInSilently()
        }
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)
        } else {
            self.accessToken = user.authentication.accessToken
            
            print(user.profile.email)
            print(user.profile.imageURL(withDimension: 400))
            UserDefaults.standard.set(accessToken, forKey: Constant().UserAccessToken)
            UserDefaults.standard.synchronize()
            
            self.contactsFetcher = ContactsFetcher(accessToken: self.accessToken!)
            self.fetchContacts()
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
    }
    
    func fetchContacts() {
        self.contactsFetcher.doFetchContactsWithURL(success: { (contacts) in
            self.getContactsEntity(contactsEntity: contacts)
        }) { (error) in
            print(error!)
        }
    }
    
    func getContactsEntity(contactsEntity:ContactsEntity?) {
        if (contactsEntity != nil) {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constant().getContactsInfoNotification), object: nil, userInfo: [Constant().userInforKey : contactsEntity!])
        }
    }

}
