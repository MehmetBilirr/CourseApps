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
    var questions = [Flags]()
    var falseChoice = [Flags]()
    
    var trueQuestion = Flags()
    var numOfQuestion = 0
    var numOfCorrect = 0
    var numOfIncorrect = 0
    var choices = [Flags]()
    var choicesMixArray = Set <Flags>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questions = FlagsAdmin().getRandomFlags()
        
        
        getQuestion()
        
        
        
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResultVC" {
            let destinationVC = segue.destination as! ResultVC
            destinationVC.numOfCorrect = numOfCorrect
            
        }
    }
    
    func getQuestion(){
        statuLabel.text = "\(numOfQuestion+1). Question"
        correctLabel.text = "Correct: \(numOfCorrect)"
        incorrectLabel.text = "Incorrect \(numOfIncorrect)"
        
        trueQuestion = questions[numOfQuestion]
        imageViewFlag.image = UIImage(named: trueQuestion.flag_image!)
        falseChoice = FlagsAdmin().getRandom3False(bayrak_id: trueQuestion.flag_id!)
        
        choicesMixArray.removeAll()
        choicesMixArray.insert(trueQuestion)
        choicesMixArray.insert(falseChoice[0])
        choicesMixArray.insert(falseChoice[1])
        choicesMixArray.insert(falseChoice[2])
        
        choices.removeAll()
        
        for b in choicesMixArray {
            choices.append(b)
        }
        
        buttonA.setTitle(choices[0].flag_name, for: .normal)
        buttonB.setTitle(choices[1].flag_name, for: .normal)
        buttonC.setTitle(choices[2].flag_name, for: .normal)
        buttonD.setTitle(choices[3].flag_name, for: .normal)
        
    }
    
    func control(button:UIButton){
        let buttonText = button.titleLabel?.text
        let correctAnswer = trueQuestion.flag_name
        
        if buttonText == correctAnswer {
            numOfCorrect += 1
        }else {
            numOfIncorrect += 1
        }
        
        correctLabel.text = "Correct: \(numOfCorrect)"
        incorrectLabel.text = "Incorrect \(numOfIncorrect)"
        
    }
    
    func controlQuestion(){
        numOfQuestion += 1
        
        if numOfQuestion != 5 {
            getQuestion()
        }else {
            performSegue(withIdentifier: "toResultVC", sender: nil)
        }
    }
    
    

    
    @IBAction func buttonAClicked(_ sender: Any) {
        control(button: buttonA)
        controlQuestion()
    }
    
    @IBAction func buttonBClicked(_ sender: Any) {
        control(button: buttonB)
        controlQuestion()
    }
    
    @IBAction func buttonCClicked(_ sender: Any) {
        control(button: buttonC)
        controlQuestion()
    }
    @IBAction func buttonDClicked(_ sender: Any) {
        control(button: buttonD)
        controlQuestion()
    }
    
}
