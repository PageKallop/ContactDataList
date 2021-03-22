//
//  ContactData.swift
//  ContactDataList
//
//  Created by Page Kallop on 3/21/21.
//

import Foundation

struct ContactData: Codable {
   
    var contacts : [Contacts]
    
}
    
  struct Contacts: Codable {
    var id : UUID
    var firstName : String
    var lastName : String
    var address : Address
    var phoneNumber : PhoneNumber
}


struct Address: Codable {
    
    var streetAddress : String
    var city : String
    var state : String
    var postalCode : String
}

struct PhoneNumber: Codable {

        var type : String
        var number : String
}
