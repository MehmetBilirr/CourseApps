//
//  ResultVC.swift
//  FlagQuiz-SQLite
//
//  Created by Mehmet Bilir on 9.05.2022.
//

import UIKit

class ResultVC: UIViewController {

    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    var numOfCorrect:Int?
    override func viewDidLoad() {
        super.viewDidLoad()

        
        navigationItem.hidesBackButton = true
        if let d = numOfCorrect {
            resultLabel.text = ("Correct: \(d)\n\n\n Incorrect: \(5-d)")
            successLabel.text = "% \(d*100/5) Success"
        }
    }
    
    @IBAction func playAgainClicked(_ sender: Any) {
        
        navigationController?.popToRootViewController(animated: true)
        
    }
    
    

}
