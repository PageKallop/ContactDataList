//
//  NetworkingService.swift
//  ContactDataList
//
//  Created by Page Kallop on 3/21/21.
//

import Foundation
import CoreData

enum Result <T>{
case Success(T)
case Error(String)
}

class NetworkingService {
    
    let persistence = PersistentService.shared
    
    var contactListFull = [ContactData]()
    
//    init() {
//       getContacts()
//    }
    
    func getContacts(completion: @escaping (Result<[[String: AnyObject]]>) -> Void ){
        
        //gets data from .json
        if let path = Bundle.main.url(forResource: "myJsonFile0", withExtension: "json") {

            do {
                
                let data = try Data(contentsOf: path)
                print("LET THE DATA     \(data)")

                if let json = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [String: AnyObject] {
                    print("LET JSON      \(json)")
 
                    guard let itemsJsonArray = json["Contact"] as? [[String: AnyObject]]
                    
                    else { return }
                    DispatchQueue.main.async {
                        completion(.Success(itemsJsonArray))
                    }
                    
                  
                    print("THE JOSN ARRAY        \(itemsJsonArray)")
                }
            } catch {
                completion(.Error(error.localizedDescription))
                print("data\(error)")
            }
          
            
        }
        
        //creates contact entity
        func createContactEntity(dictionary: [String: AnyObject]) {

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
                print(contactEntity)

            }
            //saves data to core data
            func save(array: [[String: AnyObject]]) {

                _ = array.map{ createContactEntity(dictionary: $0)}
                do {
                    try
                        PersistentService.shared.persistentContainer.viewContext.save()
                } catch {

                    print("error saving contact\(error)")

                }
            }

        }
        
    }
    
    
    
}










