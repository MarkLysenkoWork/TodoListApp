//
//  TodoListTableViewController.swift
//  TodoListApp
//
//  Created by Mark (WorkProfile) on 15.09.2020.
//  Copyright © 2020 Mark (WorkProfile). All rights reserved.
//

import UIKit

class TodoListTableViewController: UITableViewController {
    
    var itemArray = ["Granola", "Apple", "Orange"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let ac = UIAlertController(title: "Add new item", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Add Item", style: .default, handler: { (action) in
            self.itemArray.append(textField.text!)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addTextField { (alertTF) in
            alertTF.placeholder = "Create new item"
            textField = alertTF
        }
        present(ac, animated: true)
    }
}

//MARK: - Table view data source
extension TodoListTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
}

//MARK: - Table view delegate
extension TodoListTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
