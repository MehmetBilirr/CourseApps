//
//  UpdateContactVC.swift
//  ContactsApp
//
//  Created by Mehmet Bilir on 12.05.2022.
//

import UIKit
import Firebase

class UpdateContactVC: UIViewController {

    @IBOutlet weak var contactNumberText: UITextField!
    @IBOutlet weak var contactNameText: UITextField!
    var chosenContact : Contacts?
    var firestoreDB = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let contact = chosenContact{
            contactNameText.text = contact.kisi_ad
            contactNumberText.text = contact.kisi_tel
        }
       
    }
    

    @IBAction func updateClicked(_ sender: Any) {
        
        if let contact = chosenContact,let name = contactNameText.text,let number = contactNumberText.text  {
            updateContact(contactID: contact.kisi_id, contactName: name, contactNumber: number)
        }
    }
    
    func updateContact(contactID:String,contactName:String,contactNumber:String) {
        
        let data = ["contact_name":contactName,"contact_number":contactNumber]
        
        firestoreDB.collection("contacts").document(contactID).setData(data) { error in
            if error != nil {
                print(error?.localizedDescription)
            }else {
                self.navigationController?.popViewController(animated: true)
            }
        }
        
    }
    

}
