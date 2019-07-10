//
//  UsersViewController.swift
//  iCoreData
//
//  Created by Rohit Makwana on 05/07/19.
//  Copyright © 2019 Rohit Makwana. All rights reserved.
//

import UIKit
import CoreData

class UsersViewController: UIViewController {

    //=======================================================================
    // MARK:- IBOutlets
    //=======================================================================

    @IBOutlet weak var userTableView: UITableView!

    //=======================================================================
    // MARK:- Declared Variables
    //=======================================================================
    
    private var users: [User] = []
    private let reuseIdentifier = "userTableViewCell"
    private var lastIndex : Int = 0
    private let AddUserViewControllerIdentifier = "AddUserViewController"
    
    
    //=======================================================================
    // MARK:- View LifeCycle
    //=======================================================================
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Users"
        self.setDesignLayout()
        self.getUsers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.userTableView.reloadData()
    }
    
    //=======================================================================
    // MARK:- IBActions
    //=======================================================================
    
    @IBAction func addUserButtonAction(_ sender: Any) {
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: AddUserViewControllerIdentifier) as! AddUserViewController
        controller.userDelegate = self
        self.navigationController?.pushViewController(controller, animated: true)
    }

    
    //=======================================================================
    // MARK:- Public Methods
    //=======================================================================
    
    //=======================================================================
    // Set Design Layout
    //=======================================================================

    private func setDesignLayout() {
        
        self.userTableView.register(UINib(nibName: self.reuseIdentifier, bundle: nil), forCellReuseIdentifier: self.reuseIdentifier)
        self.userTableView.delegate = self
        self.userTableView.dataSource = self
    }
}


// MARK:-

extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    
    //=======================================================================
    // MARK:- UITableView Delegate &  DataSource
    //=======================================================================

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier) as! userTableViewCell
        cell.user = self.users[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .normal, title: deleteString) { action, index in
            
            AlertView.showAlert(WithTitle: deleteString, AndMessage: AlertMessage.deleteUserMessage, actions: [OKString], isShowCancel: true, completion: { (action) in
                
                self.deleteUser(atIndex: index.row)
            })
        }
        delete.backgroundColor = .lightGray
        
        let edit = UITableViewRowAction(style: .normal, title: editString) { action, index in
            
            let controller = self.storyboard?.instantiateViewController(withIdentifier: self.AddUserViewControllerIdentifier) as! AddUserViewController
            controller.user = self.users[index.row]
            self.navigationController?.pushViewController(controller, animated: true)

        }
        edit.backgroundColor = .orange
        return [delete,edit]
    }
}

// MARK:-

extension UsersViewController : UserCreatedDelegate {
    
    //=======================================================================
    // MARK:- UserAddedDelegate
    //=======================================================================

    func UserCreated() {
        
        self.getUsers()
    }
}

// MARK:-

extension UsersViewController {
    
    //=======================================================================
    // MARK:- Core Data Stuff
    //=======================================================================

    //=======================================================================
    // Get Users list
    //=======================================================================
    
    private func getUsers() {
        
        let context = appDelegate?.getManagedObjectContext()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: userEntityName)
        
        //        request.fetchLimit = 1
        //        request.predicate = NSPredicate(format: "username = %@", "Ankur")
        //        request.sortDescriptors = [NSSortDescriptor.init(key: "email", ascending: false)]
        
        request.returnsObjectsAsFaults = false
        
        do {
            
            let result = try context?.fetch(request)
            self.users = result as! [User]
            self.userTableView.reloadData()
            
        } catch {
            print("Failed")
        }
    }

    //=======================================================================
    // Delete User
    //=======================================================================

    func deleteUser(atIndex index: Int) {
        
        let context = appDelegate?.getManagedObjectContext()
        context?.delete(self.users[index])
        
        do {
            
            try context?.save()
            self.users.remove(at: index)
            self.userTableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)

        } catch {
            print(error)
        }
    }
}
