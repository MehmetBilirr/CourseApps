//
//  ContactsAdmin.swift
//  ContactsApp
//
//  Created by Mehmet Bilir on 12.05.2022.
//

import Foundation


class ContactsAdmin {
    
    let db:FMDatabase?
    
    init(){
        
        let target = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let file = URL(fileURLWithPath: target).appendingPathComponent("contactsApp.sqlite")
        
        db = FMDatabase(path: file.path)
    }



    func getContacts() -> [Contacts]{
        
        var contactArray = [Contacts]()
        db?.open()
        do {
            let rs = try db!.executeQuery("SELECT * FROM contacts", values: nil)
            while rs.next(){
                let contact = Contacts(contact_id: Int(rs.string(forColumn: "contact_id"))!, contact_name: rs.string(forColumn: "contact_name"), contact_number: rs.string(forColumn: "contact_number"))
                contactArray.append(contact)
            }
            
        }catch{
            print(error.localizedDescription)
        }
        
        
        
        
        db?.close()
        return contactArray
        
        
    }
}
