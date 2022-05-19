//
//  DetailsVC.swift
//  GradeApp
//
//  Created by Mehmet Bilir on 10.05.2022.
//

import UIKit
import Alamofire

class DetailsVC: UIViewController {

    @IBOutlet weak var grade2Text: UITextField!
    @IBOutlet weak var grade1Text: UITextField!
    @IBOutlet weak var lessonText: UITextField!
    var chosenGrade : Grades?
    override func viewDidLoad() {
        super.viewDidLoad()

        if let name = chosenGrade?.ders_adi,let g1 = chosenGrade?.not1,let g2 = chosenGrade?.not2{
            lessonText.text = name
            grade1Text.text = g1
            grade2Text.text = g2
        }
    }
    
    @IBAction func updateClicked(_ sender: Any) {
        
        updateGrade()
        navigationController?.popViewController(animated: true)
        
        
    }
    
    
    @IBAction func deleteClicked(_ sender: Any) {
        
        deleteGrade()
        navigationController?.popViewController(animated: true)
        
    }
    
    func deleteGrade(){
        
        if let id = chosenGrade?.not_id{
            
            let parameter:Parameters = ["not_id":id]
            
            Alamofire.request("http://kasimadalan.pe.hu/notlar/delete_not.php",method: .post,parameters: parameter).responseJSON { response in
                
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
    
    func updateGrade(){
        
        if let name = lessonText.text,let g1 = grade1Text.text,let g2 = grade2Text.text,let id = chosenGrade?.not_id {
            
            let parameter:Parameters = ["not_id":id,"ders_adi":name,"not1":g1,"not2":g2]
            
            Alamofire.request("http://kasimadalan.pe.hu/notlar/update_not.php",method: .post,parameters: parameter).responseJSON { response in
                
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
    

}
