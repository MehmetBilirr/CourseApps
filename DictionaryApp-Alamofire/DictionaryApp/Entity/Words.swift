//
//  Words.swift
//  DictionaryApp
//
//  Created by Mehmet Bilir on 10.05.2022.
//

import Foundation

class Words:Codable{
    
    var kelime_id:String
    var ingilizce:String
    var turkce:String
    
    
    
    init(kelime_id:String,ingilizce:String,turkce:String){
        self.kelime_id = kelime_id
        self.ingilizce = ingilizce
        self.turkce = turkce
    }
}
