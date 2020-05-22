//
//  CategoriContentCollectionViewCell.swift
//  ECommerceSample
//
//  Created by Pratik on 22/05/20.
//  Copyright © 2020 Pratik. All rights reserved.
//

import UIKit

class CategoriContentCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var labelTitle: UILabel!
    
    func cellDataSet(title: String?) {
        labelTitle.text = title
    }
}
