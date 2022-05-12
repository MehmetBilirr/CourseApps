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
    var contactArray = [Contacts]()
    var chosenContact : Contacts?
    var isSearching = false
    var searchWord : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        contactArray = ContactsAdmin().getContacts()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        contactArray = ContactsAdmin().getContacts()
        tableView.reloadData()
    }

    
    func getData(){
        
        
        let bundle = Bundle.main.path(forResource: "contactsApp", ofType: ".sqlite")!
        
        let target = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let fileManager = FileManager.default
        
        let file = URL(fileURLWithPath: target).appendingPathComponent("contactsApp.sqlite")
        
        if fileManager.fileExists(atPath: file.path) {
            
            
        }else {
            
            do {
                
                try fileManager.copyItem(atPath: bundle, toPath: file.path)
                
            }catch{
                print(error)
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
        cell.contactLabel.text = contactArray[indexPath.row].contact_name
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenContact = contactArray[indexPath.row]
        self.performSegue(withIdentifier: "toDetailsVC", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetailsVC" {
            
            let destinationVC = segue.destination as! ContactDetailsVC
            destinationVC.chosenContact = chosenContact
            
        }
        
        if segue.identifier == "toUpdateVC" {
            
            let destination = segue.destination as! UpdateContactVC
            destination.chosenContact = chosenContact
            
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { contexualAction, view, boolValue in
            ContactsAdmin().deleteContact(contact_id: self.contactArray[indexPath.row].contact_id!)
            
            
            if self.isSearching {
                self.contactArray = ContactsAdmin().search(contact_name: self.searchWord!)
            }else{
                self.contactArray = ContactsAdmin().getContacts()
            }
            
            self.tableView.reloadData()
        }
        
        let updateAction = UIContextualAction(style: .normal, title: "Update") { contexualAction, view, boolValue in
            self.performSegue(withIdentifier: "toUpdateVC", sender: indexPath.row)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction,updateAction])
    }
    
    }
extension MainVC:UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchWord = searchText
        if searchText == "" {
            
            self.contactArray = ContactsAdmin().getContacts()
        }else{
            self.contactArray = ContactsAdmin().search(contact_name: self.searchWord!)
        }
        
        
        tableView.reloadData()
    }
    
    

}

