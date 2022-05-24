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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
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

