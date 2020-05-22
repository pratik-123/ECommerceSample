//
//  ProductVariantTableViewCell.swift
//  ECommerceSample
//
//  Created by Pratik on 22/05/20.
//  Copyright © 2020 Pratik. All rights reserved.
//

import UIKit

class ProductVariantTableViewCell: UITableViewCell {
    @IBOutlet weak var labelColor: UILabel!
    @IBOutlet weak var labelSize: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellDataSetup(variant : VariantPO?) {
        labelColor.text = "Color: \(variant?.color ?? "")"
        labelSize.text = "Size: \(variant?.size.removeZeroFraction ?? "")"
        labelPrice.text = "Price: \(variant?.price.removeZeroFraction ?? "")"
    }
}
struct VariantPO {
    let color: String?
    let price: Double
    let size: Double
}
