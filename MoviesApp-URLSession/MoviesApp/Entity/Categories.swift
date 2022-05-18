//
//  Categories.swift
//  MoviesApp
//
//  Created by Mehmet Bilir on 11.05.2022.
//

import Foundation


class Categories {
    
    var category_id : Int?
    var category_name : String?
    
    
    init(category_id:Int,category_name:String){
        self.category_id = category_id
        self.category_name = category_name
        
    }
}
