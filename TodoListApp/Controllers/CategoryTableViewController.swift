//
//  CategoryTableViewController.swift
//  TodoListApp
//
//  Created by Mark (WorkProfile) on 17.09.2020.
//  Copyright © 2020 Mark (WorkProfile). All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
    
    var categories = [Category]()
    let contex = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let ac = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
            let newCategory = Category(context: self.contex)
            newCategory.name = textField.text!
            
            self.categories.append(newCategory)
            self.saveCategories()
        }))
        ac.addTextField { (field) in
            textField = field
            textField.placeholder = "Add new category"
        }
        present(ac, animated: true )
    }
    //MARK: - Data manupulation methods
    func saveCategories() {
        do {
            try contex.save()
        } catch {
            print("Error saving categories, \(error)")
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func loadCategories() {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            categories = try contex.fetch(request)
        } catch {
            print("Error loading categories, \(error)")
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

//MARK: - TableView Date source methods
extension CategoryTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }
}

//MARK: - TableView Delegate methods
extension CategoryTableViewController {
    
}


