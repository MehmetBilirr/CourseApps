//
//  SettingsVC.swift
//  GradeApp
//
//  Created by Mehmet Bilir on 10.05.2022.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet weak var grade2Text: UITextField!
    @IBOutlet weak var grade1Text: UITextField!
    @IBOutlet weak var lessonText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func addClicked(_ sender: Any) {
        
        if let lessonName = lessonText.text, let grade1 = grade1Text.text, let grade2 = grade2Text.text {
            
            if let g1 = Int(grade1),let g2 = Int(grade2){
                
                GradesAdmin().addGrade(lessonName: lessonName, grade1: g1, grade2: g2)
            }
            
            
        }
    }
    

}
