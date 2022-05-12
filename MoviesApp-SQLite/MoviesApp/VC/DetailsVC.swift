//
//  DetailsVC.swift
//  MoviesApp
//
//  Created by Mehmet Bilir on 11.05.2022.
//

import UIKit

class DetailsVC: UIViewController {

    @IBOutlet weak var movieDirector: UILabel!
    @IBOutlet weak var movieCategory: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    var chosenMovie : Movies?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let movie = chosenMovie {
            movieDirector.text = movie.director?.director_name
            movieYear.text = String(movie.movie_year!)
            movieName.text = movie.movie_name
            movieImageView.image = UIImage(named: movie.movie_image!)
            movieCategory.text = movie.category?.category_name
        
        }
    }
    

    

}
