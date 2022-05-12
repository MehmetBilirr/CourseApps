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

        
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        
        if let contactName = contactNameText.text,let contactNumber = contactNumberText.text{
            
            ContactsAdmin().addContact(contact_name: contactName, contact_number: contactNumber)
            
            navigationController?.popViewController(animated: true)
            
        }
        
        
    }
    
    

}
