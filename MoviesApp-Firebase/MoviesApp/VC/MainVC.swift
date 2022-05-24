//
//  ViewController.swift
//  MoviesApp
//
//  Created by Mehmet Bilir on 11.05.2022.
//

import UIKit
import Firebase

class MainVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var categoryArray = [Categories]()
    var firestoreDB = Firestore.firestore()
    var chosenCategory : Categories?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getCategories()
    }
    
    func getCategories(){
        firestoreDB.collection("Categories").getDocuments { snapshot, error in
            if error != nil {
                print(error?.localizedDescription)
            }else {
                if snapshot?.isEmpty == false && snapshot != nil {
                    
                    self.categoryArray.removeAll(keepingCapacity: true)
                    for document in snapshot!.documents {
                        if let id = document.documentID as? String {
                            if let name = document.get("category_name") as? String {
                                let category = Categories(kategori_id: id, kategori_ad: name)
                                self.categoryArray.append(category)
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
        return categoryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = categoryArray[indexPath.row]
        let cell = UITableViewCell()
        cell.textLabel?.text = category.kategori_ad
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenCategory = categoryArray[indexPath.row]
        performSegue(withIdentifier: "toMoviesVC", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMoviesVC" {
            let destinationVC = segue.destination as! MoviesVC
            destinationVC.chosenCategory = chosenCategory
        }
    }
    
    
    
}

