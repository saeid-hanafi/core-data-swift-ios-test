//
//  ViewController.swift
//  Core Data Test
//
//  Created by Macvps on 4/26/23.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet var nameInput: UITextField!
    @IBOutlet var familyInput: UITextField!
    @IBOutlet var passInput: UITextField!
    private let context = AppDelegate().persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func addUserBtn(_ sender: UIButton) {
        addUser()
        selectUsers()
    }
    
    private func addUser() {
        let entity = NSEntityDescription.entity(forEntityName: "Users", in: self.context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        let name = nameInput.text
        let family = familyInput.text
        let pass = passInput.text
        
        newUser.setValue(name != "" ? name : "Saeed", forKey: "name")
        newUser.setValue(family != "" ? family : "Hanafi", forKey: "family")
        newUser.setValue(pass, forKey: "pass")
        
        do {
            try context.save()
        }catch {
            print("Core Data Save Error!!")
        }
    }
    
    private func selectUsers() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                print("User Info is : \(data.value(forKey: "name") as! String) \(data.value(forKey: "family") as! String) By Pass : \(data.value(forKey: "pass") as! String)")
            }
        }catch {
            print("Core Data Select Error!!")
        }
    }
}

