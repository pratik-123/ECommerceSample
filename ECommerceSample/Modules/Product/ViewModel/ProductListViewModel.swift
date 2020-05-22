//
//  ProductListViewModel.swift
//  ECommerceSample
//
//  Created by Pratik on 22/05/20.
//  Copyright © 2020 Pratik. All rights reserved.
//

import Foundation
final class ProductListViewModel {
    var displayMessage : ((_ message : String?) -> Void)?
    var refreshData: (()->Void)?
    var arrayOfProducts = [Products]()
    var arrayOfRankings = [RankingModel]()
    
    /// Number of rows
    /// - Returns: rows count
    func numberOfRows() -> Int {
        return arrayOfProducts.count
    }
    
    func getProduct(index : Int) -> Products? {
        if arrayOfProducts.indices.contains(index) {
            let product = arrayOfProducts[index]
            return product
        }
        return nil
    }
    /// Cell data for product
    /// - Parameter index: index
    /// - Returns: cell data
    func cellData(index : Int) -> ProductDetailsPO? {
        if arrayOfProducts.indices.contains(index) {
            let product = arrayOfProducts[index]
            let obj = ProductDetailsPO(name: product.name, order_count: product.order_count, shares: product.shares, view_count: product.view_count)
            return obj
        }
        
        return nil
    }
    
    /// Ranking data get
    func getRangkings() {
        let rankings = DataMediator.shared.getRankingsData()
        arrayOfRankings = rankings.map({RankingModel(ranking: $0.ranking, key: $0.key)})
    }

    /// Sorting product list
    /// - Parameter key: keyname
    func filterData(forKey key : String) {
        ///Dynamic key pass so use NSSortDescriptor for sorting
        let sortDecriptor = NSSortDescriptor(key: key, ascending: false)
        let array = (arrayOfProducts as NSArray).sortedArray(using: [sortDecriptor])
        arrayOfProducts = (array as? [Products]) ?? []
        refreshData?()
    }
}
