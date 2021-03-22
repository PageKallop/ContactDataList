//
//  Contact+CoreDataProperties.swift
//  ContactDataList
//
//  Created by Page Kallop on 3/21/21.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var number: String?
    @NSManaged public var type: String?
    @NSManaged public var postalCode: String?
    @NSManaged public var state: String?
    @NSManaged public var city: String?
    @NSManaged public var streetAddress: String?
    @NSManaged public var lastName: String?
    @NSManaged public var firstName: String?
    @NSManaged public var id: UUID?

}

extension Contact : Identifiable {

}
