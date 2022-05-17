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
        
        if let lesson = lessonText.text,let g1 = grade1Text.text,let g2 = grade2Text.text {
            addGrade(lessonName: lesson, grade1: g1, grade2: g2)
            navigationController?.popViewController(animated: true)
        }
        
        
    }
    
    func addGrade(lessonName:String,grade1:String,grade2:String){
        
        
        var request = URLRequest(url: URL(string: "http://kasimadalan.pe.hu/notlar/insert_not.php")!)
        
        request.httpMethod = "POST"
        let postString = "ders_adi=\(lessonName)&not1=\(grade1)&not2=\(grade2)"
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
