//
//  ViewController.swift
//  MoviesApp
//
//  Created by Mehmet Bilir on 11.05.2022.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var categoryArray = [Categories]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let c1 = Categories(category_id: 1, category_name: "Dram")
        let c2 = Categories(category_id: 2, category_name: "Action")
        categoryArray.append(c1)
        categoryArray.append(c2)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
    }


}

extension MainVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = categoryArray[indexPath.row]
        let cell = UITableViewCell()
        cell.textLabel?.text = category.category_name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toMoviesVC", sender: nil)
    }
    
    
    
}

