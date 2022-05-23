//
//  AddContactVC.swift
//  ContactsApp
//
//  Created by Mehmet Bilir on 12.05.2022.
//

import UIKit
import Alamofire

class AddContactVC: UIViewController {

    @IBOutlet weak var contactNumberText: UITextField!
    @IBOutlet weak var contactNameText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        if let contactName = contactNameText.text,let contactNumber = contactNumberText.text {
            kisiEkle(contactName: contactName, contactNumber: contactNumber)
        }
        
        
        navigationController?.popViewController(animated: true)
    }
    
    func kisiEkle(contactName:String,contactNumber:String){
        let parameter:Parameters = ["kisi_ad":contactName,"kisi_tel":contactNumber]
        
        Alamofire.request("http://kasimadalan.pe.hu/kisiler/insert_kisiler.php",method: .post,parameters: parameter).responseJSON { response in
            
            if let data = response.data {
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String:Any]{
                        print(json)
                    }
                    
                    
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    

}
