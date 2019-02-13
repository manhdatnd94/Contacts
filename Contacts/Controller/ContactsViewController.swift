
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contactsTableView.delegate = self
        self.contactsTableView.dataSource = self
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign out", style: .plain, target: self, action: #selector(signOut))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign in", style: .plain, target: self, action: #selector(signIn))
        
        self.contactsDictonary = Dictionary()
        
        self.contactsTableView.register(UINib.init(nibName: "ContactsTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactsTableViewCell")
        
        //Fetch data from Google
        let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let contact = delegate.persistentContainer.viewContext
        
        let query = NSFetchRequest
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        self.setNavigationBar()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ContactsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ContactsTableViewCell", for: indexPath) as! ContactsTableViewCell
        cell.nameLabel.text = "Test"
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
