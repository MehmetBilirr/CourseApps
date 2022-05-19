//
//  SettingsVC.swift
//  GradeApp
//
//  Created by Mehmet Bilir on 10.05.2022.
//

import UIKit
import Alamofire

class SettingsVC: UIViewController {

    @IBOutlet weak var grade2Text: UITextField!
    @IBOutlet weak var grade1Text: UITextField!
    @IBOutlet weak var lessonText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func addClicked(_ sender: Any) {
        if let name = lessonText.text,let g1 = grade1Text.text,let g2=grade2Text.text{
            addGrade(gradeName: name, grade1: g1, grade2: g2)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    func addGrade(gradeName:String,grade1:String,grade2:String){
        let parameter:Parameters = ["ders_adi":gradeName,"not1":grade1,"not2":grade2]
        
        Alamofire.request("http://kasimadalan.pe.hu/notlar/insert_not.php",method: .post,parameters: parameter).responseJSON { response in
            
            if let data = response.data {
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String:Any]{
                        
                    }
                    
                    
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }

    

}
