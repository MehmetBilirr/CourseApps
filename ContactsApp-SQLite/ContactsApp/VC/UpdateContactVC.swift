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
    var chosenContact : Contacts?
    override func viewDidLoad() {
        super.viewDidLoad()

        contactNameText.text = chosenContact?.contact_name
        contactNumberText.text = chosenContact?.contact_number
    }
    

    @IBAction func updateClicked(_ sender: Any) {
        
        if let contactId = chosenContact?.contact_id,let contactName = contactNameText.text,let contactNumber = contactNumberText.text{
            
            ContactsAdmin().updateContact(contact_id: contactId, contact_name: contactName, contact_number: contactNumber)
            
            navigationController?.popViewController(animated: true)
            
        }
    }
    

}
