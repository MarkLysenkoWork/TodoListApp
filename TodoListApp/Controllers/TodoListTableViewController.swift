//
//  TodoListTableViewController.swift
//  TodoListApp
//
//  Created by Mark (WorkProfile) on 15.09.2020.
//  Copyright © 2020 Mark (WorkProfile). All rights reserved.
//

import UIKit
import RealmSwift

class TodoListTableViewController: UITableViewController {
    
    var todoItems: Results<Item>?
    let realm = try! Realm()
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //loadItems()
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let ac = UIAlertController(title: "Add new item", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Add Item", style: .default, handler: { (action) in
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error saving new items, \(error)")
                }
            }
            
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
    
//    func saveItems() {
//        do {
//            try contex.save()
//        } catch {
//            print("Error saving contex, \(error)")
//        }
//        
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//        }
//    }
    
    func loadItems() {
    
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
//        if let addtionalPredicate = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, addtionalPredicate])
//        } else {
//            request.predicate = categoryPredicate
//        }
//
//
//
//        do {
//            itemArray = try contex.fetch(request)
//        } catch {
//            print("Error fetching data from contex, \(error)")
//        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
}

//MARK: - Table view data source
extension TodoListTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Items Added"
        }
        
        
        return cell
    }
    
}

//MARK: - Table view delegate
extension TodoListTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        todoItems[indexPath.row].done = !todoItems[indexPath.row].done
//        saveItems()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - Search bar delegate
//extension TodoListTableViewController: UISearchBarDelegate {
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let request: NSFetchRequest<Item> = Item.fetchRequest()
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//        loadItems(with: request, predicate: predicate)
//    }
//    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0 {
//            loadItems()
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//            
//        }
//    }
//}
