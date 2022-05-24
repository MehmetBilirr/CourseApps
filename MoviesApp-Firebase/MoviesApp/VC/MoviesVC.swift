//
//  MoviesVC.swift
//  MoviesApp
//
//  Created by Mehmet Bilir on 11.05.2022.
//

import UIKit
import Firebase

class MoviesVC: UIViewController {

    var movieArray = [Movies]()
    @IBOutlet weak var collectionView: UICollectionView!
    var chosenCategory : Categories?
    var chosenMovie : Movies?
    var firestoreDB = Firestore.firestore()
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
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if let category = chosenCategory {
            getMoviesByCategory(categoryName: category.kategori_ad!)
        }
    }
    
    func getMoviesByCategory(categoryName:String) {
        
        firestoreDB.collection("Movies").whereField("category_name", isEqualTo: categoryName).getDocuments { snapshot, error in
            if error != nil {
                print(error?.localizedDescription)
            }else {
              if  snapshot?.isEmpty == false && snapshot != nil{
                    
                    self.movieArray.removeAll(keepingCapacity: true)
                    for document in snapshot!.documents {
                        
                        if let id = document.documentID as? String{
                            if let name = document.get("movie_name") as? String{
                                if let year = document.get("movie_year") as? String{
                                    if let director = document.get("director_name") as? String{
                                        if let category = document.get("category_name") as? String {
                                            if let image = document.get("movie_image") as? String {
                                                let movie = Movies(film_id: id, film_ad: name, film_yil: year, film_resim: image, kategori: category, yonetmen: director)
                                                self.movieArray.append(movie)
                                            }
                                            
                                        }
                                    }
                                }
                            }
                        }
                    }
                  self.collectionView.reloadData()
                }
            }
        }
        
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
        
        chosenMovie = movieArray[indexPath.row]
        
        self.performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! DetailsVC
            destinationVC.chosenMovie = chosenMovie
            
        }
    }
    
    
}
