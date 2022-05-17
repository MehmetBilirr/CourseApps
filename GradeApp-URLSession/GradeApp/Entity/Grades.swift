//
//  Grades.swift
//  GradeApp
//
//  Created by Mehmet Bilir on 10.05.2022.
//

import Foundation


class Grades:Codable {
    
    var not_id:String?
    var ders_adi:String?
    var not1:String?
    var not2:String?
    
    
    
    init(not_id:String,ders_adi:String,not1:String,not2:String){
        self.not_id = not_id
        self.ders_adi = ders_adi
        self.not1 = not1
        self.not2 = not2
    }
    
    
    
}
