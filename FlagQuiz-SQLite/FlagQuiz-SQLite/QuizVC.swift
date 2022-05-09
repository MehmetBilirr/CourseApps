//
//  QuizVC.swift
//  FlagQuiz-SQLite
//
//  Created by Mehmet Bilir on 9.05.2022.
//

import UIKit

class QuizVC: UIViewController {

    @IBOutlet weak var imageViewFlag: UIImageView!
    @IBOutlet weak var statuLabel: UILabel!
    @IBOutlet weak var incorrectLabel: UILabel!
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var buttonA: UIButton!
    @IBOutlet weak var buttonB: UIButton!
    @IBOutlet weak var buttonC: UIButton!
    @IBOutlet weak var buttonD: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
    }
    
    func getData(){
        
        
        let bundle = Bundle.main.path(forResource: "flags", ofType: ".sqlite")!
        
        let target = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let fileManager = FileManager.default
        
        let file = URL(fileURLWithPath: target).appendingPathComponent("flags.sqlite")
        
        if fileManager.fileExists(atPath: file.path) {
            
            print("Veritabanı zaten var. Kopyalamaya gerek yok.")
        }else {
            
            do {
                
                try fileManager.copyItem(atPath: bundle, toPath: file.path)
                
            }catch{
                print(error)
            }
            
            
        }
        
        }

    
    @IBAction func buttonAClicked(_ sender: Any) {
    }
    
    @IBAction func buttonBClicked(_ sender: Any) {
    }
    
    @IBAction func buttonCClicked(_ sender: Any) {
    }
    @IBAction func buttonDClicked(_ sender: Any) {
    }
    
}
