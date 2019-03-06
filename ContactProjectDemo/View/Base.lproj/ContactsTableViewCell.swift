//
//  ContactsTableViewCell.swift
//  Contacts
//
//  Created by RTC-HN360 on 2/1/19.
//  Copyright © 2019 Hypertech Team. All rights reserved.
//

import UIKit

class ContactsTableViewCell: BaseTableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCellWithEntity(entry: ContactsEntityFeedEntry) {
        if ((entry.gdEmail?.count)! > 0 && entry.gdEmail != nil) {
            self.nameLabel.text = entry.gdEmail![0].address
        } else {
            self.nameLabel.text = "Null"
        }
    }
    
}
