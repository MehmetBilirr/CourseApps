//
//  UpdateContactVC.swift
//  ContactsApp
//
//  Created by Mehmet Bilir on 12.05.2022.
//

import UIKit
import Alamofire

class UpdateContactVC: UIViewController {

    @IBOutlet weak var contactNumberText: UITextField!
    @IBOutlet weak var contactNameText: UITextField!
    var chosenContact : Contacts?
    override func viewDidLoad() {
        super.viewDidLoad()

        if let contact = chosenContact {
            contactNameText.text = chosenContact?.kisi_ad
            contactNumberText.text = chosenContact?.kisi_tel
        }
    }
    

    @IBAction func updateClicked(_ sender: Any) {
        
        if let contact = chosenContact,let name = contactNameText.text,let number = contactNumberText.text {
            updateContact(contactID: contact.kisi_id, contactName: name, contactNumber: number)
        }
        navigationController?.popViewController(animated: true)
    }
    
    
    func updateContact(contactID:String,contactName:String,contactNumber:String){
        let parameter:Parameters = ["kisi_id":contactID,"kisi_ad":contactName,"kisi_tel":contactNumber]
        
        Alamofire.request("http://kasimadalan.pe.hu/kisiler/update_kisiler.php",method: .post,parameters: parameter).responseJSON { response in
            
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
