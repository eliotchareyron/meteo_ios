//
//  meteoTableViewCell.swift
//  application_meteo
//
//  Created by etudiant on 13/04/2017.
//  Copyright © 2017 etudiant. All rights reserved.
//

import UIKit

class meteoTableViewCell: UITableViewCell {

    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var temp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
