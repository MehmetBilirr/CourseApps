//
//  MoviesVC.swift
//  MoviesApp
//
//  Created by Mehmet Bilir on 11.05.2022.
//

import UIKit

class MoviesVC: UIViewController {

    var movieArray = [Movies]()
    var ChosenCategory : Categories?
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let design = UICollectionViewFlowLayout()
        let witdh = self.collectionView.frame.size.width
        design.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let cellWidth = (witdh-30)/2
        
        design.itemSize = CGSize(width: cellWidth, height: cellWidth * 1.7)
        design.minimumInteritemSpacing = 10
        design.minimumLineSpacing = 10
        collectionView.collectionViewLayout = design
        
        if let category = ChosenCategory {
            moviesByCategoryID(category_id: category.kategori_id!)
        }
        
        
    }
    
    func moviesByCategoryID(category_id:String){
        var request = URLRequest(url: URL(string: "http://kasimadalan.pe.hu/filmler/filmler_by_kategori_id.php")!)
        request.httpMethod = "POST"
        let postString = "kategori_id=\(category_id)"
        request.httpBody = postString.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data , response , error in
            if error != nil || data == nil {
                print("Hata")
                return
            }
            
            do{
                let answer = try JSONDecoder().decode(MoviesResponse.self, from: data!)
                if let list = answer.filmler {
                    self.movieArray = list
                }
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            }catch{
                print(error.localizedDescription)
            }
            }.resume()
        
    }
    
    
    

    

}

extension MoviesVC:UICollectionViewDelegate,UICollectionViewDataSource,MoviesProtocol {
    func add(indexpath: IndexPath) {
        print("ADD button clicked : \(movieArray[indexpath.row].film_ad)")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return movieArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = movieArray[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MoviesCVC
        cell.movieLabel.text = movie.film_ad
        cell.moviePriceLabeö.text = "14.99TL"
        cell.imageViewMovie.image = UIImage(named: movie.film_resim!)
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        cell.movieProtocol = self
        cell.indexpath = indexPath
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    
}
