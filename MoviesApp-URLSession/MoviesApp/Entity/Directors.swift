//
//  Directors.swift
//  MoviesApp
//
//  Created by Mehmet Bilir on 11.05.2022.
//

import Foundation

class Directors:Codable {
    
    var yonetmen_id : String?
    var yonetmen_ad : String?
    
    
    init(yonetmen_id:String,yonetmen_ad:String){
        self.yonetmen_ad = yonetmen_ad
        self.yonetmen_id = yonetmen_id
        
    }
}
