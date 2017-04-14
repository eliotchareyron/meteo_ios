//
//  VilleTableViewCell.swift
//  application_meteo
//
//  Created by etudiant on 11/04/2017.
//  Copyright © 2017 etudiant. All rights reserved.
//

import UIKit

class VilleTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var imageview: UIImageView!
   
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
