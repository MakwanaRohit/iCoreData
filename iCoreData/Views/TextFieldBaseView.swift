//
//  TextFieldBaseView.swift
//  iCoreData
//
//  Created by Rohit Makwana on 08/07/19.
//  Copyright © 2019 Rohit Makwana. All rights reserved.
//

import UIKit

class TextFieldBaseView: UIView {

    @IBOutlet weak var textField: UITextField!
    //=======================================================================
    // MARK:- Declared Variables
    //=======================================================================
    var contentView : UIView?
    
    @IBInspectable var placeholder: String  = "" {        
        didSet {
            self.textField.placeholder = self.placeholder
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat  = 5.0 {
        didSet {
            contentView?.applyCornerRadius(With: cornerRadius)
        }
    }
    
    var text: String {
        
        get {
            return self.textField.text ?? ""
        }
    }
    
    //=======================================================================
    // MARK:- Init Methods
    //=======================================================================
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.xibSetup()
    }

    //=======================================================================
    // MARK:- XIB SetUp
    //=======================================================================
    
    fileprivate func xibSetup() {
        
        self.contentView = self.loadViewFromNib()
        contentView?.backgroundColor = AppColor.Clear
        
        self.contentView!.frame = bounds
        self.contentView!.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        
        self.addSubview(contentView!)
    }
    
    
    //=======================================================================
    // Creates a `UIView` From NIB
    //
    // - returns: The created `UIView`.
    //=======================================================================
    
    
    func loadViewFromNib() -> UIView! {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    //=======================================================================
    // Update UITextfield property using the default `keyboardType` returnKey .
    // `keyboardType` returnKey .
    //
    // - parameter keyboardType:          The keyboardType.
    // - parameter returnKey:             The returnKey.
    //=======================================================================

    func updateTextFieldProperty(_ keyboardType: UIKeyboardType, _ returnKey: UIReturnKeyType) {
        
        self.textField.keyboardType  = keyboardType
        self.textField.returnKeyType = returnKey
    }
}


