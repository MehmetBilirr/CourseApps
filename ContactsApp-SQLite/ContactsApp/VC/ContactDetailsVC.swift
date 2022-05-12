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

        contactNameLabel.text = chosenContact?.contact_name
        contactNumberLabel.text = chosenContact?.contact_number
    }
    

    

}
