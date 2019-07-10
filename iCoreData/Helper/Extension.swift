//
//  Extension.swift
//  iCoreData
//
//  Created by Rohit Makwana on 09/07/19.
//  Copyright © 2019 Rohit Makwana. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    var isBlank: Bool {
        
        get {
            return trimmingCharacters(in: CharacterSet.whitespaces).isEmpty
        }
    }
    
    
    var trimed: String {
        
        return trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    var isContainsNumbers: Bool {
        
        get {
            return NSPredicate(format:"SELF MATCHES %@", ".*[0-9]+.*").evaluate(with: self)
        }
    }
}

extension UIView {
    
    // MARK:- CORNER RADIUS
    //=======================================================================
    // Creates a `Corner Radius` using the default `radius`.
    // `radius`.
    //
    // - parameter radius:             The radius.
    //
    //=======================================================================
    
    func applyCornerRadius(With radius: CGFloat) {
        
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
}

