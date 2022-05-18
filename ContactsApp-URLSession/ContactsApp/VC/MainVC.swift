//
//  ViewController.swift
//  ContactsApp
//
//  Created by Mehmet Bilir on 12.05.2022.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var contactsArray = [Contacts]()
    var chosenContact:Contacts?
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
        
        let url = URL(string: "http://kasimadalan.pe.hu/kisiler/tum_kisiler.php")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil || data == nil {
                print(error?.localizedDescription)
            }
            do {
                let answer = try JSONDecoder().decode(ContactsResponse.self, from: data!)
                if let list = answer.kisiler {
                    self.contactsArray = list
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            
                
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func deleteContact(contact_id:String){
        
        
        var request = URLRequest(url: URL(string: "http://kasimadalan.pe.hu/kisiler/delete_kisiler.php")!)
        
        request.httpMethod = "POST"
        let postString = "kisi_id=\(contact_id)"
        request.httpBody = postString.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil || data == nil {
                print(error?.localizedDescription)
            }
            do{
                try JSONSerialization.jsonObject(with: data!)
                
                self.getContacts()
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func 

    
    


}


extension MainVC:UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsArray.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! ContactCellVC
        cell.contactLabel.text = contactsArray[indexPath.row].kisi_ad
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenContact = contactsArray[indexPath.row]
        self.performSegue(withIdentifier: "toDetailsVC", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetailsVC" {
            
            let destionationVC = segue.destination as! ContactDetailsVC
            destionationVC.chosenContact = chosenContact
            
            
        }
        
        if segue.identifier == "toUpdateVC" {
            
            let destionationVC = segue.destination as! UpdateContactVC
            destionationVC.chosenContact = chosenContact
            
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [self] contexualAction, view, boolValue in
            
            let contact = self.contactsArray[indexPath.row]
                deleteContact(contact_id: contact.kisi_id)
            
        }
        
        let updateAction = UIContextualAction(style: .normal, title: "Update") { contexualAction, view, boolValue in
            
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

