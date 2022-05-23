//
//  SettingsVC.swift
//  GradeApp
//
//  Created by Mehmet Bilir on 10.05.2022.
//

import UIKit
import Firebase

class SettingsVC: UIViewController {

    @IBOutlet weak var grade2Text: UITextField!
    @IBOutlet weak var grade1Text: UITextField!
    @IBOutlet weak var lessonText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func addClicked(_ sender: Any) {
        if let name = lessonText.text,let grade1 = grade1Text.text,let grade2 = grade2Text.text{
            addGrade(lessonName: name, grade1: grade1, grade2: grade2)
        }
    }
    
    func addGrade(lessonName:String,grade1:String,grade2:String){
        let firestore = Firestore.firestore()
        let firestorePost = ["lessonName":lessonName,"grade1":grade1,"grade2":grade2] as [String:Any]
        firestore.collection("grades").addDocument(data: firestorePost) { error in
            if error != nil {
                print(error?.localizedDescription)
            }else {
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        
        
    }

}
