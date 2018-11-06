//
//  ViewController.swift
//  Todoey
//
//  Created by James Krisnanda on 02/11/18.
//  Copyright © 2018 James Krisnanda. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    let defaults = UserDefaults.standard
    var itemArray = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item ()
        newItem2.title = "buy eggs"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "makan nasi campur"
        itemArray.append(newItem3)
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item]{
            itemArray = items
        }
    }
    
    //MARK : Tableviewdatasource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        //        value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done ? .checkmark : .none
        
    
        
        return cell
    }
    
    //  MARK  : Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
       tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //    MARK : Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "add new to do item", message: "in this section, you can create your new item", preferredStyle: .alert)
        let actionLeft = UIAlertAction(title: "add item", style: .default) { (actionLeft) in
//            what will happen once the user clicks the add item on our UIAlert
          
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
            
        }
        
            alert.addTextField { (alertTextField) in
                alertTextField.placeholder = "create new item"
                
                textField = alertTextField
            }
        
        
        let actionRight = UIAlertAction(title: "cancel everything", style: .default) { (actionRight) in
            print("cancel everything")
        }
        
        alert.addAction(actionLeft)
        alert.addAction(actionRight)
    present(alert, animated: true, completion: nil)
        
    }
    
}

