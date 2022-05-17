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
        
        if let grade = chosenGrade {
            delete(grade_id: grade.not_id!)
            navigationController?.popViewController(animated: true)
        }
        
        
        
    }
    
    func delete(grade_id:String){
        
        
        var request = URLRequest(url: URL(string: "http://kasimadalan.pe.hu/notlar/delete_not.php")!)
        
        request.httpMethod = "POST"
        let postString = "not_id=\(grade_id)"
        request.httpBody = postString.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil || data == nil {
                print(error?.localizedDescription)
            }
            do{
                try JSONSerialization.jsonObject(with: data!)
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    

}
