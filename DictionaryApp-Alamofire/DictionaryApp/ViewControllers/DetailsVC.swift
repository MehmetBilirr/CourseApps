//
//  DetailsVC.swift
//  DictionaryApp
//
//  Created by Mehmet Bilir on 10.05.2022.
//

import UIKit

class DetailsVC: UIViewController {

    
    @IBOutlet weak var trLabel: UILabel!
    @IBOutlet weak var engLabel: UILabel!
    var selectedWord : Words?
    override func viewDidLoad() {
        super.viewDidLoad()

        trLabel.text = selectedWord?.turkce
        engLabel.text = selectedWord?.ingilizce
    }
    

    

}
