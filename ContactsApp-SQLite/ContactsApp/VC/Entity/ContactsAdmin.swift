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
    
    func addContact(contact_name:String,contact_number:String){
        
        db?.open()
        do {
            let rs = try db!.executeUpdate("INSERT INTO contacts (contact_name,contact_number) VALUES (?,?)", withArgumentsIn: [contact_name,contact_number])
            
            
        }catch{
            print(error.localizedDescription)
        }
        
        
        
        
        db?.close()
        
        
        
    }
    
    func updateContact(contact_id:Int,contact_name:String,contact_number:String){
        
        db?.open()
        do {
            let rs = try db!.executeUpdate("UPDATE contacts SET contact_name = ? , contact_number = ? WHERE contact_id = ?", withArgumentsIn: [contact_name,contact_number,contact_id])
            
            
        }catch{
            print(error.localizedDescription)
        }
        
        
        
        
        db?.close()
        
        
        
    }
    
    func deleteContact(contact_id:Int){
        
        db?.open()
        do {
            let rs = try db!.executeUpdate("DELETE FROM contacts WHERE contact_id = ?", withArgumentsIn: [contact_id])
            
            
        }catch{
            print(error.localizedDescription)
        }
        
        
        
        
        db?.close()
        
        
        
    }
}
