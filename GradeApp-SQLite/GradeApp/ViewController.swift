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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        gradesArray = GradesAdmin().getAllGrades()
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "gradeCell", for: indexPath) as! GradeCell
        cell.lessonLabel.text = gradesArray[indexPath.row].lesson_name
        cell.grade1.text = grade.lesson_name
        cell.grade1.text = String(grade.grade1!)
        cell.grade2.text = String(grade.grade2!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    
    
}

