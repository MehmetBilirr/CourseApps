//
//  MoviesAdmin.swift
//  MoviesApp
//
//  Created by Mehmet Bilir on 11.05.2022.
//

import Foundation


class MoviesAdmin {
    
    
    let db:FMDatabase?
    
    init(){
        
        let target = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let file = URL(fileURLWithPath: target).appendingPathComponent("moviesApp.sqlite")
        
        db = FMDatabase(path: file.path)
 }
    
    
    
    
}
