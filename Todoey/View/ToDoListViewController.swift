//
//  ViewController.swift
//  Todoey
//
//  Created by James Krisnanda on 02/11/18.
//  Copyright © 2018 James Krisnanda. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    //
    //    var textField : UITextField = {
    //      var textField = UITextField()
    //        textField.backgroundColor = .red
    //        return textField
    //
    //    }()
    //
    
    //     ini closure pake cashtag dollar.
    var textField : UITextField = {
        $0.backgroundColor = UIColor.red
        return $0
    }(UITextField())
    
    
    
    var itemArray = [Item]()
    let defaults = UserDefaults.standard
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        print(dataFilePath)
        //
        //
        //        let newItem = Item()
        //        newItem.title = "Cari mantan"
        //        itemArray.append(newItem)
        //
        //        let newItem2 = Item ()
        //        newItem2.title = "makan temen"
        //        itemArray.append(newItem2)
        //
        //        let newItem3 = Item()
        //        newItem3.title = "makan nasi campur"
        //        itemArray.append(newItem3)
        //
        loadItems()
        //
        //        if let items = defaults.array(forKey: "ToDoListArray") as? [Item]{
        //            itemArray = items
        //
        //        }
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
        //        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableView.reloadData()
    }
    
    //    MARK : Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
        let alert = UIAlertController(title: "add new to do item", message: "in this section, you can create your new item", preferredStyle: .alert)
        let actionLeft = UIAlertAction(title: "add item", style: .default) { (actionLeft) in
            //            what will happen once the user clicks the add item on our UIAlert
            self.saveItems()
            //            alert.addTextField(configurationHandler: <#T##((UITextField) -> Void)?##((UITextField) -> Void)?##(UITextField) -> Void#>)
            
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "create new item"
            alertTextField.textColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
            self.textField = alertTextField}
        
        
        
        
        let actionRight = UIAlertAction(title: "cancel everything", style: .default) { (actionRight) in
            print("cancel everything")
        }
        
        alert.addAction(actionLeft)
        alert.addAction(actionRight)
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveItems(){
        if textField.text!.isEmpty == !textField.text!.isEmpty{
            let newItem = Item()
            newItem.title = textField.text!
            itemArray.append(newItem)
            
            let encoder = PropertyListEncoder()
            do{
                let data = try encoder.encode(itemArray)
                try data.write(to: dataFilePath!)
                
            }
            catch {
                print("error data file path \(error)")
            }
        }
        
        
        self.tableView.reloadData()
    }
        
    func loadItems (){
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            
            do {
                itemArray = try decoder.decode([Item].self , from: data )
            }
            catch {
                print("error load items : \(error)")
            }
            
            
            
        }
    }
}

