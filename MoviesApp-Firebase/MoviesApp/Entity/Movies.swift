//
//  Movies.swift
//  MoviesApp
//
//  Created by Mehmet Bilir on 11.05.2022.
//

import Foundation

class Movies:Codable {
    
    var film_id : String?
    var film_ad : String?
    var film_yil : String?
    var film_resim : String?
    var kategori : String?
    var yonetmen : String?
    
    
    init(film_id:String,film_ad:String,film_yil:String,film_resim:String,kategori:String,yonetmen:String){
        
        self.film_ad = film_ad
        self.film_id = film_id
        self.film_resim = film_resim
        self.film_yil = film_yil
        self.kategori = kategori
        self.yonetmen = yonetmen
        
        
    }
}
