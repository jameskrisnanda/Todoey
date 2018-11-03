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
    var itemArray = [
        "Find james", "check writing", "drawing face"
   
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [String]{
            itemArray = items
        }
    }
    
    //MARK : Tableviewdatasource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //  MARK  : Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if  tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            print("uncheck \(itemArray[indexPath.row])")
        }else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            print(itemArray[indexPath.row])
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //    MARK : Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "add new to do item", message: "in this section, you can create your new item", preferredStyle: .alert)
        let actionLeft = UIAlertAction(title: "add item", style: .default) { (actionLeft) in
//            what will happen once the user clicks the add item on our UIAlert
           self.itemArray.append(textField.text!)
            
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

