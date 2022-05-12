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
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
