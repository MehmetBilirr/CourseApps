//
//  GradeCell.swift
//  GradeApp
//
//  Created by Mehmet Bilir on 10.05.2022.
//

import UIKit

class GradeCell: UITableViewCell {

    @IBOutlet weak var grade2: UILabel!
    @IBOutlet weak var grade1: UILabel!
    @IBOutlet weak var lessonLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
