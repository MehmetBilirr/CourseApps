//
//  Contacts.swift
//  ContactsApp
//
//  Created by Mehmet Bilir on 12.05.2022.
//

import Foundation


class Contacts {
    
    var contact_id:Int?
    var contact_name:String?
    var contact_number:String?
    
    init(contact_id:Int,contact_name:String,contact_number:String){
        
        self.contact_id = contact_id
        self.contact_name = contact_name
        self.contact_number = contact_number
    }
}
