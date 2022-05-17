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
        
        let word1 = Words(word_id: 1, word_eng: "Table", word_tr: "Masa")
        let word2 = Words(word_id: 2, word_eng: "Door", word_tr: "Kapı")
        let word3 = Words(word_id: 3, word_eng: "Window", word_tr: "Pencere")
        wordsArray.append(word1)
        wordsArray.append(word2)
        wordsArray.append(word3)
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        
        
    }


}

extension ViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DictionaryCell", for: indexPath) as! DictionaryViewCell
        cell.trText.text = wordsArray[indexPath.row].word_tr
        cell.engLabel.text = wordsArray[indexPath.row].word_eng
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
