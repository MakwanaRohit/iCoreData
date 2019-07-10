//
//  Validation.swift
//  iCoreData
//
//  Created by Rohit Makwana on 09/07/19.
//  Copyright © 2019 Rohit Makwana. All rights reserved.
//

import Foundation

class Validation: NSObject {
    
    //=======================================================================
    // Creates a `Validation` Instance
    //
    // - returns: The created `Validation` Instance.
    //=======================================================================
    
    static let shared: Validation =  Validation()
    
    //=======================================================================
    // Creates Bool for Email is Valid or not
    // `email`.
    //
    // - parameter email:       The email String
    //
    // - returns: The created `Bool` for Email valid or not.
    //=======================================================================
    
    fileprivate class func isValidEmail(_ email:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    
    //=======================================================================
    // Creates Bool for Phone Number is Valid or not
    // `phoneNumber`.
    //
    // - parameter phoneNumber:       The phoneNumber String
    //
    // - returns: The created `Bool` for Phone Number valid or not.
    //=======================================================================
    
    fileprivate class func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        
        let charcterSet  = NSCharacterSet(charactersIn: "0123456789").inverted
        let inputString = phoneNumber.components(separatedBy: charcterSet)
        let filtered = inputString.joined(separator: "")
        return phoneNumber == filtered
    }
    
    
    //=======================================================================
    // Check String contains Space or Not Range using `str`
    // `password`.
    //
    // - parameter password:       The password String
    //
    // - returns: The created `Bool` for String Contains White Space.
    //=======================================================================
    
    func isContainsWhiteSpace(_ str: String) -> Bool {
        
        if !str.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }
        return true
    }
    
    
    //=======================================================================
    // Check phoneNumber Range
    // `phoneNumber`.
    //
    // - parameter phoneNumber:       The phoneNumber String
    //
    // - returns: The created `Bool` for phoneNumber range valid or not.
    //=======================================================================
    
    fileprivate class func isPhoneNumberNotInRange(_ phoneNumber: String) -> Bool {
        
        if !(phoneNumber.count >= 8 &&  phoneNumber.count <= 12) {
            return true
        }
        return false
    }
}


extension Validation {
    
    func isEmailReady(_ email: String) -> (Bool, String) {
        
        if email.isBlank {
            
            return (false, AlertMessage.emailAlert)
        }
        else if !Validation.isValidEmail(email)  {
            
            return (false, AlertMessage.emailValidAlert)
        }
        else {
            
            return (true, "")
        }
    }
    
    func isReadyPhoneNumber(_ mobileNumber: String) -> (Bool, String) {
        
        if mobileNumber.isBlank {
            return (false, AlertMessage.phoneNumberAlert)
        }
        else if !(Validation.isValidPhoneNumber(mobileNumber)) {
            
            return (false, AlertMessage.phoneNumberValidAlert)
        }
        else if (Validation.isPhoneNumberNotInRange(mobileNumber)) {
            
            return (false, AlertMessage.phoneNumberValidAlert)
        }
        else {
            
            return (true, "")
        }
    }
}
