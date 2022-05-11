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
    
    func getMovies(category_id:Int) -> [Movies]{
        
        var movieArray = [Movies]()
        db?.open()
        do {
            let rs = try db!.executeQuery("SELECT * FROM categories,directors,movies WHERE movies.category_id = categories.category_id and movies.director_id = directors.director_id and movies.category_id = ?", values: [category_id])
            while rs.next(){
                let category = Categories(category_id: Int(rs.string(forColumn: "category_id"))!, category_name: rs.string(forColumn: "category_name"))
                let director = Directors(director_id: Int(rs.string(forColumn: "director_id"))!, director_name: rs.string(forColumn: "director_name")!)
                let movie = Movies(movie_id: Int(rs.string(forColumn: "movie_id"))!, movie_name: rs.string(forColumn: "movie_name"), movie_year: Int(rs.string(forColumn: "movie_year"))!, movie_image: rs.string(forColumn: "movie_image"), category: category, director: director)
                movieArray.append(movie)
            }
            
        }catch{
            print(error.localizedDescription)
        }
        
        
        
        
        db?.close()
        return movieArray
        
        
    }
    
    
    
    
}
