//
//  GradesAdmin.swift
//  GradeApp
//
//  Created by Mehmet Bilir on 10.05.2022.
//

import Foundation

class GradesAdmin{
    
    let db:FMDatabase?
    
    init(){
        
        let target = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let file = URL(fileURLWithPath: target).appendingPathComponent("grades.sqlite")
        
        db = FMDatabase(path: file.path)
 }
    
    func getAllGrades() -> [Grades] {
        
        var gradesArray = [Grades]()
        db?.open()
        do {
            let rs = try db!.executeQuery("SELECT * FROM grades", values: nil)
            while rs.next(){
                let grade = Grades(grade_id: Int(rs.string(forColumn: "grade_id"))!, lesson_name: (rs.string(forColumn: "lesson_name")), grade1: Int(rs.string(forColumn: "grade1"))!, grade2: Int(rs.string(forColumn: "grade2"))!)
                gradesArray.append(grade)
            }
            
        }catch{
            print(error.localizedDescription)
        }
        
        
        
        
        db?.close()
        return gradesArray
    }
    
    func addGrade(lessonName:String,grade1:Int,grade2:Int){
        
        db?.open()
        do {
            let rs = try db!.executeUpdate("INSERT INTO grades (lesson_name,grade1,grade2) VALUES (?,?,?)", withArgumentsIn: [lessonName,grade1,grade2])
            
            
        }catch{
            print(error.localizedDescription)
        }
        
        
        
        
        db?.close()
        
        
        
    }
    func updateGrade(grade_id:Int,lessonName:String,grade1:Int,grade2:Int){
        
        db?.open()
        do {
            let rs = try db!.executeUpdate("UPDATE grades SET lesson_name = ? , grade1 = ? , grade2 = ? WHERE grade_id = ?", withArgumentsIn: [lessonName,grade1,grade2,grade_id])
            
            
        }catch{
            print(error.localizedDescription)
        }
        
        
        
        
        db?.close()
        
        
        
    }
    
    
    func deleteGrade(grade_id:Int){
        
        db?.open()
        do {
            let rs = try db!.executeUpdate("DELETE FROM grades WHERE grade_id = ?", withArgumentsIn: [grade_id])
            
            
        }catch{
            print(error.localizedDescription)
        }
        
        
        
        
        db?.close()
        
        
        
    }
    
    
    
    

}
