//
//  ViewController.swift
//  DictionaryApp
//
//  Created by Mehmet Bilir on 10.05.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var wordsArray = [Words]()
    var selectedWord : Words?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        GetWords()
        
        
        
        
        
        
        
    }
    
    func GetWords(){
        
        let url = URL(string: "http://kasimadalan.pe.hu/sozluk/tum_kelimeler.php")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil || data == nil {
                print(error?.localizedDescription)
            }
            
            do{
                let answer = try JSONDecoder().decode(DictionaryResponse.self, from: data!)
                if let list = answer.kelimeler{
                    self.wordsArray = list
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
        
        
        
    }


}

extension ViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DictionaryCell", for: indexPath) as! DictionaryViewCell
        cell.trText.text = wordsArray[indexPath.row].turkce
        cell.engLabel.text = wordsArray[indexPath.row].ingilizce
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedWord = wordsArray[indexPath.row]
        self.performSegue(withIdentifier: "toDetailsVC", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! DetailsVC
            destinationVC.selectedWord = selectedWord
        }
    }
    
    
}

extension ViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Arama Sonucu : \(searchText)")
    }
}
