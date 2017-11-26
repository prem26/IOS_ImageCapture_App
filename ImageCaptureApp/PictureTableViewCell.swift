//
//  PictureTableViewCell.swift
//  ImageCaptureApp
//
//  Created by Herath Mudiyanselage Nethanjan Danindu Premaratne on 3/11/17.
//  Copyright © 2017 Herath Mudiyanselage Nethanjan Danindu Premaratne. All rights reserved.
//

import UIKit
import CoreData

class PictureTableViewCell: UITableViewCell {

    
    // Outlet details in table view
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
