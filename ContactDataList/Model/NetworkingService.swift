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
    
    var contactListFull = [ContactData]()
    
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
                
                if let json = try  JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [String: AnyObject] {
                    print(json)
                    guard let itemsJsonArray = json["contact"] as? [[String: AnyObject]]
                   
                    else { return
                    }
            
                }
                
              func createContactEntity(dictionary: [String: AnyObject]) {
                
                let contactList = dataFromJson.contacts
                let listOfContacts = Contact(context: persistence.context)
                    
                    let context = PersistentService.shared.persistentContainer.viewContext
                    if let contactEntity = NSEntityDescription.insertNewObject(forEntityName: "Contact", into: context) as? Contact {
                        contactEntity.id = dictionary["id"] as? UUID
                        contactEntity.firstName = dictionary["firstName"] as? String
                        contactEntity.lastName = dictionary["lastName"] as? String
                        contactEntity.streetAddress = dictionary["streetAddress"] as? String
                        contactEntity.city = dictionary["city"] as? String
                        contactEntity.state = dictionary["state"] as? String
                        contactEntity.postalCode = dictionary["postalCode"] as? String
                        contactEntity.type = dictionary["type"] as? String
                        contactEntity.number = dictionary["number"] as? String
                        
                      
//                        self.persistence.save()
                        
                    }
                    
                   print(context)
                    
                
                   
                }
                
  
            

//                let contactList = dataFromJson.contacts
//
//                let listOfContacts = Contact(context: persistence.context)
                
                
              
//
//                listOfContacts.firstName = contactList[0].firstName
//                listOfContacts.lastName = contactList[0].lastName
//                listOfContacts.streetAddress = contactList[0].address.streetAddress
//                listOfContacts.city = contactList[0].address.city
//                listOfContacts.state = contactList[0].address.state
//                listOfContacts.postalCode = contactList[0].address.postalCode
//                listOfContacts.type = contactList[0].phoneNumber.type
//                listOfContacts.number = contactList[0].phoneNumber.number
//
//
//
//                    self.persistence.save()


            
                
                
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
