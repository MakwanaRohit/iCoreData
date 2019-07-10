//
//  Helper.swift
//  iCoreData
//
//  Created by Rohit Makwana on 08/07/19.
//  Copyright © 2019 Rohit Makwana. All rights reserved.
//

import Foundation
import UIKit

let appDelegate   = UIApplication.shared.delegate as? AppDelegate
var AppName       : String { return "Base Project" }
let OKString      = "OK"
let deleteString  = "Delete"
let editString    = "Edit"
let userEntityName = "User"


struct AppColor {
    
    static let Clear = UIColor.clear
    static let Red   = UIColor.red
}

struct AlertMessage {
    
    static let emailAlert              = "Please enter Email"
    static let emailValidAlert         = "Please enter valid Email"
    static let phoneNumberAlert        = "Enter your mobile number"
    static let phoneNumberValidAlert   = "Enter your valid mobile number"
    static let userNameAlert           = "Enter user name"
    
    static let createMessage           = "Record Created successfully"
    static let updateMessage           = "Record Updated successfully"
    static let deleteUserMessage       = "Are you sure you want to delete ?"
}
