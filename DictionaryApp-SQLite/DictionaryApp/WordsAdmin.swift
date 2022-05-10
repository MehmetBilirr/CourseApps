//
//  WordsAdmin.swift
//  DictionaryApp
//
//  Created by Mehmet Bilir on 10.05.2022.
//

import Foundation

class WordsAdmin{
    

let db:FMDatabase?

init(){
    
    let target = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    
    let file = URL(fileURLWithPath: target).appendingPathComponent("dictionary.sqlite")
    
    db = FMDatabase(path: file.path)
    
    }
    
    func getWords() -> [Words]{
        
        var wordArray = [Words]()
        
        db?.open()
        
        do {
            
            let rs = try db!.executeQuery("SELECT * FROM words", values: nil)
            while (rs.next()) {
                let word = Words(word_id: Int(rs.string(forColumn: "word_id"))!, word_eng: rs.string(forColumn: "word_eng")!, word_tr: rs.string(forColumn: "word_tr")!)
                wordArray.append(word)
            }
            
            
        }catch {
            print(error.localizedDescription)
        }
        
        
        db?.close()
        return wordArray
    }
    
    
    func search(english:String) -> [Words]{
        
        var wordArray = [Words]()
        
        db?.open()
        
        do {
            
            let rs = try db!.executeQuery("SELECT * FROM words WHERE english like '%\(english)%' ", values: nil)
            while (rs.next()) {
                let word = Words(word_id: Int(rs.string(forColumn: "word_id"))!, word_eng: rs.string(forColumn: "word_eng"), word_tr: rs.string(forColumn: "word_tr"))
            }
            
            
        }catch {
            print(error.localizedDescription)
        }
        
        
        db?.close()
        return wordArray
    }
}
