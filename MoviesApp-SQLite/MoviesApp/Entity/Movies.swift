//
//  Movies.swift
//  MoviesApp
//
//  Created by Mehmet Bilir on 11.05.2022.
//

import Foundation

class Movies {
    
    var movie_id : Int?
    var movie_name : String?
    var movie_year : Int?
    var movie_image : String?
    var category : Categories?
    var director : Directors?
    
    
    init(movie_id:Int,movie_name:String,movie_year:Int,movie_image:String,category:Categories,director:Directors){
        
        self.movie_id = movie_id
        self.movie_name = movie_name
        self.movie_year = movie_year
        self.movie_image = movie_image
        self.category = category
        self.director = director
        
        
    }
}
