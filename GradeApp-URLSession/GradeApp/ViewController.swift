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
        
        
        let g1 = Grades(grade_id: 1, lesson_name: "Math", grade1: 90, grade2: 90)
        let g2 = Grades(grade_id: 2, lesson_name: "Chemistry", grade1: 80, grade2: 90)
        gradesArray.append(g1)
        gradesArray.append(g2)
        tableView.delegate = self
        tableView.dataSource = self
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

