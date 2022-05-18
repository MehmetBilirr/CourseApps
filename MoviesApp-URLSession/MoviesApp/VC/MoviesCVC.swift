//
//  MoviesCVC.swift
//  MoviesApp
//
//  Created by Mehmet Bilir on 11.05.2022.
//

import UIKit

protocol MoviesProtocol {
    
    func add(indexpath:IndexPath)
}

class MoviesCVC: UICollectionViewCell {
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var imageViewMovie: UIImageView!
    @IBOutlet weak var moviePriceLabeö: UILabel!
    
    var movieProtocol : MoviesProtocol?
    var indexpath:IndexPath?
    
    @IBAction func addClicked(_ sender: Any) {
        
        movieProtocol?.add(indexpath: indexpath!)
        
    }
}
