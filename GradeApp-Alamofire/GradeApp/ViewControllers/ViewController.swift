//
//  ViewController.swift
//  GradeApp
//
//  Created by Mehmet Bilir on 10.05.2022.
//

import UIKit
import Alamofire

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
        
        
        Alamofire.request("http://kasimadalan.pe.hu/notlar/tum_notlar.php",method: .get).responseJSON { response in
            
            if let data = response.data {
                
                do {
                    let answer = try JSONDecoder().decode(GradesResponse.self, from: data)
                    if let list = answer.notlar{
                        self.gradesArray = list
                    }
                    DispatchQueue.main.async {
                        
                        var sum = 0
                        
                        for i in self.gradesArray {
                            
                            if let n1 = Int(i.not1!),let n2 = Int(i.not2!){
                                sum = sum + (n1 + n2)/2
                                
                            }
                            
                            
                        }
                        
                        if self.gradesArray.count != 0 {
                            self.navigationItem.prompt = "Average : \(sum/self.gradesArray.count)"
                        }else {
                            self.navigationItem.prompt = "No Average "
                        }
                        
                        self.tableView.reloadData()
                    }
                    
                    
                }catch{
                    print(error.localizedDescription)
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

