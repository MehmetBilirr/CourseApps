//
//  AddContactVC.swift
//  ContactsApp
//
//  Created by Mehmet Bilir on 12.05.2022.
//

import UIKit

class AddContactVC: UIViewController {

    @IBOutlet weak var contactNumberText: UITextField!
    @IBOutlet weak var contactNameText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        if contactNameText.text != "" && contactNumberText.text != "" {
             
            if let contactName = contactNameText.text,let contactNumber = contactNumberText.text {
                
                addContact(contactName: contactName, contactNumber: contactNumber)
                
            }
            
        }
        
        navigationController?.popViewController(animated: true)
        
        
        
    }
    
    func addContact(contactName:String,contactNumber:String){
        
        
        var request = URLRequest(url: URL(string: "http://kasimadalan.pe.hu/kisiler/insert_kisiler.php")!)
        
        request.httpMethod = "POST"
        let postString = "kisi_ad=\(contactName)&kisi_tel=\(contactNumber)"
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
