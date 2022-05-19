//
//  ViewController.swift
//  DictionaryApp
//
//  Created by Mehmet Bilir on 10.05.2022.
//

import UIKit
import Alamofire

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
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getWords()
    }
    
    func getWords(){
        
        Alamofire.request("http://kasimadalan.pe.hu/sozluk/tum_kelimeler.php",method: .get).responseJSON { response in
            
            if let data = response.data {
                
                do {
                    let cevap = try JSONDecoder().decode(DictionaryResponse.self, from: data)
                    if let liste = cevap.kelimeler{
                        
                        self.wordsArray = liste
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
    
    func searchWord(word:String){
        let parameter:Parameters = ["ingilizce":word]
        
        Alamofire.request("http://kasimadalan.pe.hu/sozluk/kelime_ara.php",method: .post,parameters: parameter).responseJSON { response in
            
            if let data = response.data {
                
                do {
                    let answer = try JSONDecoder().decode(DictionaryResponse.self, from: data)
                    if let list = answer.kelimeler{
                        self.wordsArray = list
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
        searchWord(word: searchText)
    }
}
