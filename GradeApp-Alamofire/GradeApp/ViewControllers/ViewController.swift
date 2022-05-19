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
        self.performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    
    
}

