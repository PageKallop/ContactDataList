//
//  NetworkingService.swift
//  ContactDataList
//
//  Created by Page Kallop on 3/21/21.
//

import Foundation
import CoreData

class NetworkingService {
    
    let persistence = PersistentService.shared
    
    var contactList = [ContactData]()
    
    init() {
        getContacts()
    }
    
    func getContacts() {
        
        if let path = Bundle.main.url(forResource: "myJsonFile0", withExtension: "json") {
            print(path)
            
            do {
                let data = try Data(contentsOf: path)
                let jsonDecoder = JSONDecoder()
            
       
                let dataFromJson = try jsonDecoder.decode(ContactData.self, from: data)
                
                let contactList = dataFromJson.contacts
               
                let listOfContacts = Contact(context: persistence.context)
                
                listOfContacts.id = contactList[0].id
                listOfContacts.firstName = contactList[0].firstName
                listOfContacts.lastName = contactList[0].lastName
                listOfContacts.streetAddress = contactList[0].address.streetAddress
                listOfContacts.city = contactList[0].address.city
                listOfContacts.state = contactList[0].address.state
                listOfContacts.postalCode = contactList[0].address.postalCode
                listOfContacts.type = contactList[0].phoneNumber.type
                listOfContacts.number = contactList[0].phoneNumber.number
               
                print(listOfContacts)
                
                
            }catch {
                print("data \(error)")
            }
            
        }
        
        
    }
    
    
}



class DataImporter {
  let importContext: NSManagedObjectContext

  init(persistentContainer: NSPersistentContainer) {
    importContext = persistentContainer.newBackgroundContext()
    importContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
  }
}
