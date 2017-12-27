//
//  ViewController.swift
//  ToDoApp
//
//  Created by Grace Tay on 12/19/17.
//  Copyright © 2017 Grace Tay. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: SwipeTableViewController {

    var toDoItems: Results<Item>?
    let realm = try! Realm()
    var toDoListArrayKey = "ToDoListArray"
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 80
        
        print(dataFilePath)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK:- Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let item = toDoItems?[indexPath.row] {
            
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No items added"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = toDoItems?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                }
            }   catch {
                    print("Error updating data: \(error)")
            }
        }
        
        tableView.reloadData()

        tableView.deselectRow(at: indexPath, animated: true)
       
    }
    
    //Mark:- Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
      
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New To Do Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            if let currentCategory = self.selectedCategory {

                do {
                    try  self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dataCreated = Date()
                        currentCategory.items.append(newItem)
                        
                    }
                } catch {
                    print("Error adding new item \(error)")
                }
                
                self.tableView.reloadData()
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
    
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK:- Model Manipulation Methods

    func loadItems() {

        toDoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

        tableView.reloadData()
    }
    
}

//MARK:- Search Bar

extension ToDoListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        toDoItems = toDoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}

