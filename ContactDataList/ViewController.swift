//
//  ViewController.swift
//  ContactDataList
//
//  Created by Page Kallop on 3/21/21.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

  
    var fetchedResultsController: NSFetchedResultsController<Contact>!

    let viewContext = PersistentService.shared.persistentContainer.viewContext
    
    var networkService = NetworkingService()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
 
        tableViewConstraints()
        loadSavedData()
     
        self.tableView.delegate = self
        self.tableView.dataSource = self

        //registers cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    

  //creates tableview
    let tableView : UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    //creates tableview constraints
    func tableViewConstraints() {
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    
 
    //loads saved data from core data
    func loadSavedData() {
        
        if fetchedResultsController == nil {
            let request = NSFetchRequest<Contact>(entityName: "Contact")
            let lastNameSort = NSSortDescriptor(key: "lastName", ascending: true)
            request.sortDescriptors = [lastNameSort]
            
            fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: viewContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchedResultsController.delegate = self
        }
        do {
            try fetchedResultsController.performFetch()
            tableView.reloadData()
        } catch {
            print("Fetch failed \(error)")
        }
    }
    
    //notifies receiver that the fetched results controller has completed processing
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    

    
    // notifies receiver fetched results is about to update
    internal func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    //returns number of rows with contact
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionList = fetchedResultsController.sections?[section]
        
        return sectionList!.numberOfObjects
    }
    
    //creates reusable cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let list = fetchedResultsController.object(at: indexPath)
        
        cell.textLabel?.text = list.city
        return cell 
    }


}

