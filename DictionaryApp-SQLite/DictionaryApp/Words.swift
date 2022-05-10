//
//  Words.swift
//  DictionaryApp
//
//  Created by Mehmet Bilir on 10.05.2022.
//

import Foundation

class Words{
    
    var word_id:Int
    var word_eng:String
    var word_tr:String
    
    
    
    init(word_id:Int,word_eng:String,word_tr:String){
        self.word_id = word_id
        self.word_tr = word_tr
        self.word_eng = word_eng
    }
}
