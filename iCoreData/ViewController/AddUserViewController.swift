//
//  AddUserViewController.swift
//  iCoreData
//
//  Created by Rohit Makwana on 08/07/19.
//  Copyright © 2019 Rohit Makwana. All rights reserved.
//

import UIKit
import CoreData

struct USerKeys {
    
    let userName     = "userName"
    let email        = "email"
    let mobileNumber = "mobileNumber"
}

protocol UserCreatedDelegate {
    
    func UserCreated()
}

class AddUserViewController: UIViewController {
    
    //=======================================================================
    // MARK:- IBOutlets
    //=======================================================================

    @IBOutlet weak var userNameView: TextFieldBaseView!
    @IBOutlet weak var emailView: TextFieldBaseView!
    @IBOutlet weak var mobileNumberView: TextFieldBaseView!
    @IBOutlet weak var doneButton: UIButton!
    
    //=======================================================================
    // MARK:- Declared Variables
    //=======================================================================

    var user: User?
    var userDelegate : UserCreatedDelegate?
    
    //=======================================================================
    // MARK:- View LifeCycle
    //=======================================================================

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setDesignLayout()
        self.setBasicData()
    }
    
    //=======================================================================
    // MARK:- IBActions
    //=======================================================================

    @IBAction func doneButtonAction(_ sender: Any) {
        
        self.view.endEditing(true)
        if self.userNameView.text.isBlank {
            
            self.userNameView.textField.text = ""
            AlertView.showAlert(Withmessage: AlertMessage.userNameAlert, action: OKString)
        }
        else {
            
            let mobileValidation = Validation.shared.isReadyPhoneNumber(self.mobileNumberView.text)
            if !mobileValidation.0 {
                AlertView.showAlert(Withmessage: mobileValidation.1, action: OKString)
            }
            else {
                
                let emailValidation = Validation.shared.isEmailReady(self.emailView.text)
                if !emailValidation.0 {
                    AlertView.showAlert(Withmessage: emailValidation.1, action: OKString)
                }
                else  {
                    self.createAndUpdateUser()
                }
            }
        }
    }
    
    
    //=======================================================================
    // MARK:- Public Methods
    //=======================================================================
    
    //=======================================================================
    // Set Design Layout
    //=======================================================================
    
    private func setDesignLayout() {
        
        self.emailView.applyCornerRadius(With: 5.0)
        self.userNameView.applyCornerRadius(With: 5.0)
        self.mobileNumberView.applyCornerRadius(With: 5.0)
        self.doneButton.applyCornerRadius(With: 5.0)
        
        self.userNameView.updateTextFieldProperty(.default, .next)
        self.mobileNumberView.updateTextFieldProperty(.numberPad, .next)
        self.emailView.updateTextFieldProperty(.emailAddress, .done)
        
        self.userNameView.textField.delegate = self
        self.mobileNumberView.textField.delegate = self
        self.emailView.textField.delegate = self
    }
    
    //=======================================================================
    // Set Basic Data
    //=======================================================================

    private func setBasicData() {
        
        self.userNameView.textField.text = self.user?.userName ?? ""
        self.mobileNumberView.textField.text = self.user?.mobileNumber ?? ""
        self.emailView.textField.text = self.user?.email ?? ""
        self.title = "Add user"
    }

    //=======================================================================
    // Create or Update user data
    //=======================================================================

    private func createAndUpdateUser() {
        
        //we need to create a content from this container
        let managedContext = appDelegate!.getManagedObjectContext()

        if self.user == nil {
            
            //Now let's create an entity and new user records.
            let userEntity = NSEntityDescription.entity(forEntityName: userEntityName, in: managedContext)!
            
            let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
            user.setValue(self.userNameView.text, forKey: USerKeys().userName)
            user.setValue(self.emailView.text, forKey: USerKeys().email)
            user.setValue(self.mobileNumberView.text, forKey: USerKeys().mobileNumber)
        }
        else{
            
            user?.setValue(self.userNameView.text, forKey: USerKeys().userName)
            user?.setValue(self.emailView.text, forKey: USerKeys().email)
            user?.setValue(self.mobileNumberView.text, forKey: USerKeys().mobileNumber)
        }
        
        //Save in Coredata
        
        do {
            try managedContext.save()
            
            AlertView.showAlert(WithTitle:"", AndMessage: self.user == nil ? AlertMessage.createMessage : AlertMessage.updateMessage, actions: [OKString]) { (action) in
                
                self.userDelegate?.UserCreated()
                self.navigationController?.popViewController(animated: true)
            }
            
        } catch let err as NSError {
            print("Could not save.\(err) \(err.description)")
        }
    }
}

// MARK:-

extension AddUserViewController: UITextFieldDelegate {
    
    //=======================================================================
    // MARK:- UITextField Delegate
    //=======================================================================

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.userNameView.textField {
            self.mobileNumberView.textField.becomeFirstResponder()
        }
        if textField == self.mobileNumberView.textField {
            self.emailView.textField.becomeFirstResponder()
        }
        else{
            textField.resignFirstResponder()
        }
        
        return true
    }
}
