//
//  MoviesVC.swift
//  MoviesApp
//
//  Created by Mehmet Bilir on 11.05.2022.
//

import UIKit

class MoviesVC: UIViewController {

    var movieArray = [Movies]()
    var chosenCategory : Categories?
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        movieArray = MoviesAdmin().getMovies(category_id: (chosenCategory?.category_id!)!)
        
        
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
