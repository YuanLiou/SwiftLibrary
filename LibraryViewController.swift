//
//  ViewController.swift
//  SwiftLibrary
//
//  Created by 劉瑞元 on 2022/4/13.
//

import UIKit
import CoreData

// Note: protocol basically interface in Java
class LibraryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var books = [Book]()
    
    // Note: onCreate()
    override func viewDidLoad() {
        tableView.delegate = self
        
        // Note: setAdapter()
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("view did appear")
        let fetchRequest = NSFetchRequest<Book>(entityName: "Book")
        do {
            let results = try managedObjectContext.fetch(fetchRequest)
            books = results
        } catch let error as NSError {
            self.showAlertViewController(message: "Couldn't load library data.")
            print("Could not fetch \(error), \(error.userInfo)")
        }
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    // this is literary an Android ListAdapter
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Note: onBindViewHolder()
        let cellIdentifier = "BookTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BookTableViewCell
        
        let targetBook = books[indexPath.row]
        cell.labelTitle.text = targetBook.title
        cell.labelAuthor.text = targetBook.author
        
        if let url = URL(string: targetBook.imageUri!) {
            UIImage.loadFrom(url: url) { image in
                cell.imgThumbnail.image = image
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            // remove the deleted item from the model
            managedObjectContext.delete(books[indexPath.row])
            books.remove(at: indexPath.row)
            saveManagedObjectContext()
            
            // remove the deleted item from the `UITableView`
            self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            
        default:
            return
        }
    }
}
