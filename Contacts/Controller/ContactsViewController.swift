
//
//  ContactsViewController.swift
//  Contacts
//
//  Created by RTC-HN360 on 2/1/19.
//  Copyright © 2019 Hypertech Team. All rights reserved.
//

import UIKit
import Google
import CoreData


class ContactsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, GIDSignInUIDelegate {
    
    @IBOutlet weak var contactsTableView: UITableView!
    var contactsDictonary:Dictionary = [String:String]()
    var contactsFetcher:ContactsFetcher?
    var contactEnitity:ContactsEntity?
    var listContact:Array<Any>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contactsTableView.delegate = self
        self.contactsTableView.dataSource = self
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        self.listContact = []
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign out", style: .plain, target: self, action: #selector(signOut))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign in", style: .plain, target: self, action: #selector(signIn))
        
        self.contactsTableView.register(UINib.init(nibName: "ContactsTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactsTableViewCell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name(rawValue: Constant().getContactsInfoNotification), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        self.setNavigationBar()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberRow = self.contactEnitity?.feed?.entry?.count
        if (numberRow == nil || numberRow! == 0) {
            return 0
        } else {
            return numberRow!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ContactsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ContactsTableViewCell", for: indexPath) as! ContactsTableViewCell
        if ((self.contactEnitity?.feed?.entry?.count)! > 0) {
            let entry = self.contactEnitity?.feed?.entry?[indexPath.row] as! ContactsEntityFeedEntry
            cell.setCellWithEntity(entry: entry)
//            for entry in (self.contactEnitity?.feed?.entry)! {
//                if ((entry.gdEmail?.count)! > 0 && entry.gdEmail != nil) {
//                    cell.nameLabel.text = entry.gdEmail![0].address
//                } else {
//                    cell.nameLabel.text = "Null"
//                }
//            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc:ContactsDetailViewController = storyBoard.instantiateViewController(withIdentifier: "ContactsDetailViewController") as? ContactsDetailViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func signOut() {
        GIDSignIn.sharedInstance()?.signOut()
        UserDefaults.standard.removeObject(forKey: Constant().UserAccessToken)
        self.setNavigationBar()
    }
    
    @objc func signIn() {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    @objc func getData(notification:Notification) {
        self.contactEnitity = notification.userInfo![Constant().userInforKey] as? ContactsEntity
        DispatchQueue.main.async {
            self.contactsTableView.reloadData()
        }
    }
    
    func setNavigationBar() {
        let token = UserDefaults.standard.string(forKey: Constant().UserAccessToken)
        if (token != nil) {
            self.navigationItem.leftBarButtonItem?.isEnabled = true
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            self.navigationItem.leftBarButtonItem?.isEnabled = false
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
}
