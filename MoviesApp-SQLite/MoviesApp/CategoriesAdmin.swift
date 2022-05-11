//
//  CategoriesAdmin.swift
//  MoviesApp
//
//  Created by Mehmet Bilir on 11.05.2022.
//

import Foundation

class CategoriesAdmin {
    
    
    let db:FMDatabase?
    
    init(){
        
        let target = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let file = URL(fileURLWithPath: target).appendingPathComponent("moviesApp.sqlite")
        
        db = FMDatabase(path: file.path)
 }
    
    func getCategories() -> [Categories]{
        
        var categoryArray = [Categories]()
        db?.open()
        do {
            let rs = try db!.executeQuery("SELECT * FROM categories", values: nil)
            while rs.next(){
                let category = Categories(category_id: Int(rs.string(forColumn: "category_id"))!, category_name: rs.string(forColumn: "category_name"))
                categoryArray.append(category)
            }
            
        }catch{
            print(error.localizedDescription)
        }
        
        
        
        
        db?.close()
        return categoryArray
        
        
    }
    
    
    
    
}
