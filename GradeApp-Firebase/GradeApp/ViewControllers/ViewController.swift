//
//  ViewController.swift
//  GradeApp
//
//  Created by Mehmet Bilir on 10.05.2022.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var gradesArray = [Grades]()
    var chosenGrade : Grades?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        getGrades()
    }
    
    
    func getGrades(){
        
        let firestoreData = Firestore.firestore()
        firestoreData.collection("grades").addSnapshotListener { snapshot, error in
            if error != nil {
                print(error?.localizedDescription)
            }else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    
                    self.gradesArray.removeAll(keepingCapacity: true)
                    for document in snapshot!.documents {
                        
                        if let id = document.documentID as? String{
                            if let lesson = document.get("lessonName") as? String{
                                if let grade1 = document.get("grade1") as? String{
                                    if let grade2 = document.get("grade2") as? String {
                                        let grade = Grades(not_id: id, ders_adi: lesson, not1: grade1, not2: grade2)
                                        self.gradesArray.append(grade)
                                    }
                                }
                            }
                        }
                        
                        
                    }
                    DispatchQueue.main.async {
                        var sum = 0
                        for i in self.gradesArray {
                            if let g1 = Int(i.not1!),let g2 = Int(i.not2!){
                                sum = sum + (g1+g2)/2
                            }
                            
                            if self.gradesArray.count != 0 {
                                self.navigationItem.prompt = "Average : \(sum/self.gradesArray.count)"
                            }else {
                                self.navigationItem.prompt = "No Average "
                            }
                        }
                        
                        self.tableView.reloadData()
                    }
                }
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
        cell.lessonLabel.text = gradesArray[indexPath.row].ders_adi
        cell.grade1.text = grade.ders_adi
        cell.grade1.text = String(grade.not1!)
        cell.grade2.text = String(grade.not2!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenGrade = gradesArray[indexPath.row]
        self.performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! DetailsVC
            destinationVC.chosenGrade = chosenGrade
        }
    }
    
    
    
}

