//
//  userTableViewCell.swift
//  iCoreData
//
//  Created by Rohit Makwana on 09/07/19.
//  Copyright © 2019 Rohit Makwana. All rights reserved.
//

import UIKit

class userTableViewCell: UITableViewCell {
    
    //=======================================================================
    // MARK:- IBOutlets
    //=======================================================================

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var mobileNumberLabel: UILabel!

    //=======================================================================
    // MARK:- Declared Variables
    //=======================================================================

    var user : User? = nil {
        
        didSet {
            
            if self.user != nil {
                
                self.userNameLabel.text = self.user?.userName ?? ""
                self.mobileNumberLabel.text = self.user?.mobileNumber ?? ""
                self.emailLabel.text = self.user?.email ?? ""
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
