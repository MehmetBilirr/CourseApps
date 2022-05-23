//
//  DetailsVC.swift
//  GradeApp
//
//  Created by Mehmet Bilir on 10.05.2022.
//

import UIKit
import Firebase

class DetailsVC: UIViewController {

    @IBOutlet weak var grade2Text: UITextField!
    @IBOutlet weak var grade1Text: UITextField!
    @IBOutlet weak var lessonText: UITextField!
    var firestoreDB = Firestore.firestore()
    var chosenGrade : Grades?
    override func viewDidLoad() {
        super.viewDidLoad()

        if let grade = chosenGrade {
            lessonText.text = grade.ders_adi
            grade1Text.text = grade.not1
            grade2Text.text = grade.not2
        }
    }
    
    @IBAction func updateClicked(_ sender: Any) {
        
        
    }
    
    
    @IBAction func deleteClicked(_ sender: Any) {
        if let grade = chosenGrade{
            deleteGrade(gradeID: grade.not_id!)
        }
        
    }
    
    func deleteGrade(gradeID:String){
        
        firestoreDB.collection("grades").document(gradeID).delete { error in
            if error != nil {
                print(error?.localizedDescription)
                
            }else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func updateGrade
    

}
