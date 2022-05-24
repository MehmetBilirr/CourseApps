//
//  AddContactVC.swift
//  ContactsApp
//
//  Created by Mehmet Bilir on 12.05.2022.
//

import UIKit
import Firebase

class AddContactVC: UIViewController {

    @IBOutlet weak var contactNumberText: UITextField!
    @IBOutlet weak var contactNameText: UITextField!
    var firestoreDB = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        
        if let name = contactNameText.text, let number = contactNumberText.text {
            addContact(contactName: name, ContactNumber: number)
        }
    }
    
    func addContact(contactName:String,ContactNumber:String){
        
        
        let data = ["contact_name":contactName,"contact_number":ContactNumber]
        
        firestoreDB.collection("contacts").addDocument(data: data) { error in
            if error != nil {
                print(error?.localizedDescription)
            }else {
                self.navigationController?.popViewController(animated: true)
            }
        }
 
    }
    
    
}
