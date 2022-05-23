//
//  ViewController.swift
//  ContactsApp
//
//  Created by Mehmet Bilir on 12.05.2022.
//

import UIKit
import Alamofire

class MainVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var contactArray = [Contacts]()
    var chosenContact : Contacts?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        getContacts()
    }
    
    
    func getContacts(){
        
        
        Alamofire.request("http://kasimadalan.pe.hu/kisiler/tum_kisiler.php",method: .get).responseJSON { response in
            
            if let data = response.data {
                
                do {
                    let answer = try JSONDecoder().decode(ContactsResponse.self, from: data)
                    if let list = answer.kisiler{
                        self.contactArray = list
                    }
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                    
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func deleteContact(contactID:String){
        let parameter:Parameters = ["kisi_id":contactID]
        
        Alamofire.request("http://kasimadalan.pe.hu/kisiler/delete_kisiler.php",method: .post,parameters: parameter).responseJSON { response in
            
            if let data = response.data {
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String:Any]{
                        print(json)
                    }
                    DispatchQueue.main.async {
                        self.getContacts()
                    }
                    
                    
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }


}


extension MainVC:UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactArray.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! ContactCellVC
        cell.contactLabel.text = contactArray[indexPath.row].kisi_ad
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenContact = contactArray[indexPath.row]
        self.performSegue(withIdentifier: "toDetailsVC", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetailsVC" {
            
            let desVC = segue.destination as! ContactDetailsVC
            desVC.chosenContact = chosenContact
        }
        
        if segue.identifier == "toUpdateVC" {
            
            let destinationVC = segue.destination as! UpdateContactVC
            destinationVC.chosenContact = chosenContact
            
            
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { contexualAction, view, boolValue in
            
            let contact = self.contactArray[indexPath.row]
            self.deleteContact(contactID: contact.kisi_id)

            
        }
        
        let updateAction = UIContextualAction(style: .normal, title: "Update") { contexualAction, view, boolValue in
            self.chosenContact = self.contactArray[indexPath.row]
            self.performSegue(withIdentifier: "toUpdateVC", sender: indexPath.row)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction,updateAction])
    }
    
    }
extension MainVC:UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("search : \(searchText)")
    }
    
    

}

