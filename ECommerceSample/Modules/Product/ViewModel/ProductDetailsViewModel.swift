//
//  ProductDetailsViewModel.swift
//  ECommerceSample
//
//  Created by Pratik on 22/05/20.
//  Copyright © 2020 Pratik. All rights reserved.
//

import Foundation
final class ProductDetailsViewModel {
    var displayMessage : ((_ message : String?) -> Void)?
    var refreshData: (()->Void)?
    var product : Products?
    func numberOfSections() -> Int {
        return 2
    }
    func numberOfRows(section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            let count = product?.hasVariants?.allObjects.count
            return count ?? 0
        }
    }
    /// Cell data for product
    /// - Returns: cell data
    func cellProductData() -> ProductDetailsPO? {
        if let product = product {
            let obj = ProductDetailsPO(name: product.name, order_count: product.order_count, shares: product.shares, view_count: product.view_count)
            return obj
        }
        return nil
    }
    
    func variantData(index : Int) -> VariantPO? {
        if let arrayOfVariants = product?.hasVariants?.allObjects as? [Variants], arrayOfVariants.indices.contains(index) {
            let variant = arrayOfVariants[index]
            let obj = VariantPO(color: variant.color, price: variant.price, size: variant.size)
            return obj
        }
        return nil
    }
}
