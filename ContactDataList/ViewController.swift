//
//  ViewController.swift
//  ContactDataList
//
//  Created by Page Kallop on 3/21/21.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var fetchedResultsController: NSFetchedResultsController<Contact>!
    
    var contact = NetworkingService()
    
    var contacts = NetworkingService().contactList

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableViewConstraints()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // Do any additional setup after loading the view.
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    let tableView : UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    func tableViewConstraints() {
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let list = contacts[indexPath.row]
        cell.textLabel?.text = list.contacts[0].firstName
        return cell 
    }

}

