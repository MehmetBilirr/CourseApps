//
//  ViewController.swift
//  GradeApp
//
//  Created by Mehmet Bilir on 10.05.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var gradesArray = [Grades]()
    var chosenLesson : Grades?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        tableView.dataSource = self
        tableView.delegate = self
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        gradesArray = GradesAdmin().getAllGrades()
        
        var total = 0
        
        for i in gradesArray {
            total += (i.grade1! + i.grade2!)/2
            
        }
        
        if gradesArray.count != 0 {
            
            navigationItem.prompt = "Average: \(total / gradesArray.count)"
            
        }else {
            
            navigationItem.prompt = "Average: )"
            
        }
        
        
        
        tableView.reloadData()
    }
    
    
    func getData(){
        
        
        let bundle = Bundle.main.path(forResource: "grades", ofType: ".sqlite")!
        
        let target = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let fileManager = FileManager.default
        
        let file = URL(fileURLWithPath: target).appendingPathComponent("grades.sqlite")
        
        if fileManager.fileExists(atPath: file.path) {
            
            
        }else {
            
            do {
                
                try fileManager.copyItem(atPath: bundle, toPath: file.path)
                
            }catch{
                print(error)
            }
            
            
        }
        
        }


}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gradesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let grade = gradesArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "gradeCell") as! GradeCell
        cell.lessonLabel.text = grade.lesson_name
        cell.grade1.text = String(grade.grade1!)
        cell.grade2.text = String(grade.grade2!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenLesson = gradesArray[indexPath.row]
        self.performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! DetailsVC
            destinationVC.chosenLesson = chosenLesson
        }
    }
    
    
    
}

