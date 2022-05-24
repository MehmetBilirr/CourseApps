//
//  ViewController.swift
//  ContactsApp
//
//  Created by Mehmet Bilir on 12.05.2022.
//

import UIKit
import Firebase
class MainVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var contactArray = [Contacts]()
    var firestoreDB = Firestore.firestore()
    var chose
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
        
        firestoreDB.collection("contacts").getDocuments { snapshot, error in
            if error != nil {
                print(error?.localizedDescription)
            }else {
                if snapshot?.isEmpty == false && snapshot != nil {
                    
                    self.contactArray.removeAll(keepingCapacity: true)
                    for document in snapshot!.documents {
                        
                        if let id = document.documentID as? String {
                            if let name = document.get("contact_name") as? String {
                                if let number = document.get("contact_number") as? String {
                                    let contact = Contacts(kisi_ad: name, kisi_tel: number, kisi_id: id)
                                    self.contactArray.append(contact)
                                }
                            }
                        }
                        
                    }
                    self.tableView.reloadData()
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
        self.performSegue(withIdentifier: "toDetailsVC", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetailsVC" {
            
            
        }
        
        if segue.identifier == "toUpdateVC" {
            
            
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { contexualAction, view, boolValue in
            print("Delete  clicked \(self.contactArray[indexPath.row])")
        }
        
        let updateAction = UIContextualAction(style: .normal, title: "Update") { contexualAction, view, boolValue in
            print("Update Clicked \(self.contactArray[indexPath.row])")
            self.performSegue(withIdentifier: "toDetailsVC", sender: indexPath.row)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction,updateAction])
    }
    
    }
extension MainVC:UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("search : \(searchText)")
    }
    
    

}

