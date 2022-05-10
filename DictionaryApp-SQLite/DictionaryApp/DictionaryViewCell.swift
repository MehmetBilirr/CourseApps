//
//  DictionaryViewCell.swift
//  DictionaryApp
//
//  Created by Mehmet Bilir on 10.05.2022.
//

import UIKit

class DictionaryViewCell: UITableViewCell {

    @IBOutlet weak var trText: UILabel!
    @IBOutlet weak var engLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
