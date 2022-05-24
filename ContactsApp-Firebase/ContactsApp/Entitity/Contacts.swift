//
//  Contacts.swift
//  ContactsApp
//
//  Created by Mehmet Bilir on 18.05.2022.
//

import Foundation

class Contacts:Codable {
    
    
    var kisi_ad:String
    var kisi_tel:String
    
    init(kisi_ad:String,kisi_tel:String){
        self.kisi_ad = kisi_ad
        self.kisi_tel = kisi_tel
        
    }
}
