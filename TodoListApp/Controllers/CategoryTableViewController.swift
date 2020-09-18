//
//  CategoryTableViewController.swift
//  TodoListApp
//
//  Created by Mark (WorkProfile) on 17.09.2020.
//  Copyright © 2020 Mark (WorkProfile). All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit

class CategoryTableViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        loadCategories()
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let ac = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
            let newCategory = Category( )
            newCategory.name = textField.text!
            self.save(category: newCategory)
        }))
        ac.addTextField { (field) in
            textField = field
            textField.placeholder = "Add new category"
        }
        present(ac, animated: true )
    }
    //MARK: - Data manupulation methods
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving categories, \(error)")
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func loadCategories() {
        categories = realm.objects(Category.self)
        
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    //MARK: - Delete Data from Swipe
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDelete = self.categories?[indexPath.row] {
            
            do {
                try self.realm.write {
                    self.realm.delete(categoryForDelete)
                }
            } catch {
                print("Error delet category, \(error)")
            }
            
        }
    }
}

//MARK: - TableView Date source methods
extension CategoryTableViewController {
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = categories? [indexPath.row].name ?? "No Categories added yet"
        return cell
    }
}

//MARK: - TableView Delegate methods
extension CategoryTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListTableViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
}



