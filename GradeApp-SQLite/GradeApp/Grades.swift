//
//  Grades.swift
//  GradeApp
//
//  Created by Mehmet Bilir on 10.05.2022.
//

import Foundation


class Grades {
    
    var grade_id:Int?
    var lesson_name:String?
    var grade1:Int?
    var grade2:Int?
    
    
    
    init(grade_id:Int,lesson_name:String,grade1:Int,grade2:Int){
        self.lesson_name = lesson_name
        self.grade1 = grade1
        self.grade2 = grade2
        self.grade_id = grade_id
    }
    
    
    
}
