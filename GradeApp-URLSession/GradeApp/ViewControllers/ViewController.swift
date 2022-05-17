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
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        getGrades()
    }
    
    
    func getGrades(){
        
        let url = URL(string: "http://kasimadalan.pe.hu/notlar/tum_notlar.php")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil || data == nil {
                print(error?.localizedDescription)
            }
            do {
                let answer = try JSONDecoder().decode(GradesResponse.self, from: data!)
                if let list = answer.notlar {
                    self.gradesArray = list
                }else {
                    self.gradesArray = [Grades]()
                }
                
                DispatchQueue.main.async {
                    var toplam = 0
                    for i in self.gradesArray {
                        if let n1 = Int(i.not1!),let n2 = Int(i.not2!) {
                            toplam = toplam + (n1+n2)/2
                        }
                    }
                    
                    if self.gradesArray.count != 0 {
                        self.navigationItem.prompt = "Average: \(toplam/self.gradesArray.count)"
                    }else {
                        self.navigationItem.prompt = "NO Avearage"
                    }
                    self.tableView.reloadData()
                }
                
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
    }


}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gradesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let grade = gradesArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "gradeCell", for: indexPath) as! GradeCell
        cell.lessonLabel.text = grade.ders_adi
        cell.grade1.text = grade.not1
        cell.grade2.text = grade.not2
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    
    
}

