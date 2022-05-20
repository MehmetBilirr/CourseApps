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
        cell.textLabel?.text = category.kategori_ad
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toMoviesVC", sender: nil)
    }
    
    
    
}

