//
//  DetailsVC.swift
//  GradeApp
//
//  Created by Mehmet Bilir on 10.05.2022.
//

import UIKit

class DetailsVC: UIViewController {

    @IBOutlet weak var grade2Text: UITextField!
    @IBOutlet weak var grade1Text: UITextField!
    @IBOutlet weak var lessonText: UITextField!
    var chosenLesson : Grades?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let lesson = chosenLesson{
            
        
            grade1Text.text = String(lesson.grade1!)
            lessonText.text = lesson.lesson_name
            grade2Text.text = String(lesson.grade2!)
        }
        
    }
    @IBAction func updateClicked(_ sender: Any) {
        if let lesson = chosenLesson {
            
            if let lessonName = lessonText.text, let grade1 = grade1Text.text, let grade2 = grade2Text.text {
                
                if let g1 = Int(grade1) , let g2 = Int(grade2) {
                    GradesAdmin().updateGrade(grade_id: lesson.grade_id!, lessonName: lessonName, grade1: g1, grade2: g2)
                    navigationController?.popToRootViewController(animated: true)
                }
            }
            
            
        }
        
    }
    
    @IBAction func deleteClicked(_ sender: Any) {
        
        if let lesson = chosenLesson {
            GradesAdmin().deleteGrade(grade_id: lesson.grade_id!)
            navigationController?.popToRootViewController(animated: true)
            
        }
    }
    
    
    

}
