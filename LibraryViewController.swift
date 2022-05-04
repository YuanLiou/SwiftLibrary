//
//  ViewController.swift
//  SwiftLibrary
//
//  Created by 劉瑞元 on 2022/4/13.
//

import UIKit

// Note: protocol basically interface in Java
class LibraryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    // Note: onCreate()
    override func viewDidLoad() {
        tableView.delegate = self
        
        // Note: setAdapter()
        tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Note: onBindViewHolder()
        let cellIdentifier = "BookTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BookTableViewCell
        return cell
    }
}

