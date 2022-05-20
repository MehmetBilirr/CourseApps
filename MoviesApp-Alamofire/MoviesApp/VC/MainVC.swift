//
//  ViewController.swift
//  MoviesApp
//
//  Created by Mehmet Bilir on 11.05.2022.
//

import UIKit
import Alamofire

class MainVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var categoryArray = [Categories]()
    var chosenCategory:Categories?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getCategories()
    }
    
    func getCategories(){
        
        
        Alamofire.request("http://kasimadalan.pe.hu/filmler/tum_kategoriler.php",method: .get).responseJSON { response in
            
            if let data = response.data {
                
                do {
                    let answer = try JSONDecoder().decode(CategoryResponse.self, from: data)
                    if let list = answer.kategoriler{
                        
                        self.categoryArray = list
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

