//
//  ProductDetailsTableViewCell.swift
//  ECommerceSample
//
//  Created by Pratik on 22/05/20.
//  Copyright © 2020 Pratik. All rights reserved.
//

import UIKit

class ProductDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var labelViewCount: UILabel!
    @IBOutlet weak var labelviewShareCount: UILabel!
    @IBOutlet weak var labelviewOrderCount: UILabel!
    @IBOutlet weak var labelName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellDataSet(obj: ProductDetailsPO?) {
        labelViewCount.text = "Most Viewed Products: \(obj?.view_count ?? 0)"
        labelviewShareCount.text = "Most Shared Products: \(obj?.shares ?? 0)"
        labelviewOrderCount.text = "Most Ordered Products: \(obj?.order_count ?? 0)"
        labelName.text = "Name: \(obj?.name ?? "")"
    }

}

struct ProductDetailsPO {
    let name: String?
    let order_count: Int64
    let shares: Int64
    let view_count: Int64
}
