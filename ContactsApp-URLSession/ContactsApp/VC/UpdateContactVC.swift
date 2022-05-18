//
//  UpdateContactVC.swift
//  ContactsApp
//
//  Created by Mehmet Bilir on 12.05.2022.
//

import UIKit

class UpdateContactVC: UIViewController {

    @IBOutlet weak var contactNumberText: UITextField!
    @IBOutlet weak var contactNameText: UITextField!
    var chosenContact:Contacts?
    override func viewDidLoad() {
        super.viewDidLoad()
        contactNumberText.text = chosenContact?.kisi_tel
        contactNameText.text = chosenContact?.kisi_ad
        
    }
    

    @IBAction func updateClicked(_ sender: Any) {
        
        if contactNumberText.text != "" && contactNameText.text != "" {
            if let number = contactNumberText.text,let name = contactNameText.text,let id = chosenContact?.kisi_id{
                update(contact_id: id, contact_name: name, contact_number: number)
            }
        }
        
        
        
    }
    
    func update(contact_id:String,contact_name:String,contact_number:String){
        
        
        var request = URLRequest(url: URL(string: "http://kasimadalan.pe.hu/kisiler/update_kisiler.php")!)
        
        request.httpMethod = "POST"
        let postString = "kisi_id=\(contact_id)&kisi_ad=\(contact_name)&kisi_tel=\(contact_name)"
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
