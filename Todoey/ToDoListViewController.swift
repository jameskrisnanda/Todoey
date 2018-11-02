//
//  ViewController.swift
//  Todoey
//
//  Created by James Krisnanda on 02/11/18.
//  Copyright © 2018 James Krisnanda. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    let itemArray = [
        "Find james", "check writing", "drawing face"
        
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    
    
}

