//
//  ContactDetailsVC.swift
//  ContactsApp
//
//  Created by Mehmet Bilir on 12.05.2022.
//

import UIKit

class ContactDetailsVC: UIViewController {

    @IBOutlet weak var contactNumberLabel: UILabel!
    @IBOutlet weak var contactNameLabel: UILabel!
    var chosenContact : Contacts?
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let contact = chosenContact {
            contactNumberLabel.text = contact.kisi_tel
            contactNameLabel.text = contact.kisi_ad
        }
    }
    

    

}
