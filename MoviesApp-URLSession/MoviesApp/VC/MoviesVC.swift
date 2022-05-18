//
//  MoviesVC.swift
//  MoviesApp
//
//  Created by Mehmet Bilir on 11.05.2022.
//

import UIKit

class MoviesVC: UIViewController {

    var movieArray = [Movies]()
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let c1 = Categories(category_id: 1, category_name: "Dram")
        let c2 = Categories(category_id: 2, category_name: "Action")
        
        let d1 = Directors(director_id: 1, director_name: "adsad")
        let d2 = Directors(director_id: 2, director_name: "adfadsad")
        
        let m1 = Movies(movie_id: 1, movie_name: "Django", movie_year: 2012, movie_image: "django", category: c1, director: d1)
        let m2 = Movies(movie_id: 2, movie_name: "Inception", movie_year: 2012, movie_image: "inception", category: c2, director: d2)
        
        movieArray.append(m1)
        movieArray.append(m2)
        
        
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
    
    
    

    

}

extension MoviesVC:UICollectionViewDelegate,UICollectionViewDataSource,MoviesProtocol {
    func add(indexpath: IndexPath) {
        print("ADD button clicked : \(movieArray[indexpath.row].movie_name!)")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return movieArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = movieArray[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MoviesCVC
        cell.movieLabel.text = movie.movie_name
        cell.moviePriceLabeö.text = "14.99TL"
        cell.imageViewMovie.image = UIImage(named: movie.movie_image!)
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
