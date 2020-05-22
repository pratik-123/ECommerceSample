//
//  CategoriTableViewHeader.swift
//  ECommerceSample
//
//  Created by Pratik on 22/05/20.
//  Copyright © 2020 Pratik. All rights reserved.
//

import UIKit

class CategoriTableViewHeader: UITableViewCell {
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var buttonViewAll: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setCellData(title : String?) {
        labelTitle.text = title
    }
}
