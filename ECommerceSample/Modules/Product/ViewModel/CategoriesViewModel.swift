//
//  CategoriesViewModel.swift
//  ECommerceSample
//
//  Created by Pratik on 19/05/20.
//  Copyright © 2020 Pratik. All rights reserved.
//

import Foundation
final class CategoriesViewModel {
    var displayMessage : ((_ message : String?) -> Void)?
    var refreshData: (()->Void)?
    var arrayOfCategory: [Categories] = []
    
    /// Category data get
    func getCategoryData() {
        if Reachability.Connection.self != .none {
            getDataFromServer()
            /// If in feture API response not found / not valid then use below methed to read data
//            getDataFromJsonFile()
        } else {
            getDataFormDB()
        }
    }
    
    /// Category data get from sever
    func getDataFromServer() {
        DataMediator.shared.getCategoryData(dataType: .CategoryList) { (isSuccess, message) in
            DispatchQueue.main.async {
                if isSuccess {
                    self.getDataFormDB()
                } else {
                    self.displayMessage?(message)
                }
            }
        }
    }
    
    /// Data read from json file
    func getDataFromJsonFile() {
        DataMediator.shared.getCategoryFromJsonFile() { (isSuccess, message) in
            DispatchQueue.main.async {
                if isSuccess {
                    self.getDataFormDB()
                } else {
                    self.displayMessage?(message)
                }
            }
        }
    }
    
    /// Category data get
    /// - Returns: array of categories
    func getDataFormDB() {
        var array = DataMediator.shared.getCategoriesData()
        array = array.filter({!($0.hasProducts?.allObjects.isEmpty ?? true)})
        array = array.sorted(by: { (($0.name ?? "") < ($1.name ?? "")) })
        arrayOfCategory = array
        refreshData?()
    }
}
extension CategoriesViewModel {
    func numberOfSections() -> Int {
        return arrayOfCategory.count
    }
    func titleForHeader(index : Int) -> String? {
        if arrayOfCategory.indices.contains(index) {
            return arrayOfCategory[index].name
        }
        return " "
    }
    func numberOfRows(section : Int) -> Int {
        return 1
    }
    func numberOfProducts(section : Int) -> Int {
        if arrayOfCategory.indices.contains(section) {
            return arrayOfCategory[section].hasProducts?.allObjects.count ?? 0
        }
        return 0
    }
    
    func productList(section: Int) -> [String?] {
        if arrayOfCategory.indices.contains(section) {
            var array = (arrayOfCategory[section].hasProducts?.allObjects as? [Products])?.map({ $0.name})
            array = array?.sorted(by: {($0 ?? "") < ($1 ?? "")})
            return (array ?? [])
        }
        return []
    }
    
    func getAllProducts(index: Int) -> [Products] {
        if arrayOfCategory.indices.contains(index) {
            var array = (arrayOfCategory[index].hasProducts?.allObjects as? [Products])
            array = array?.sorted(by: {($0.name ?? "") < ($1.name ?? "")})
            return (array ?? [])
        }
        return []
    }
    
    func getProduct(row: Int, section: Int) -> Products? {
        if arrayOfCategory.indices.contains(section) {
            var array = (arrayOfCategory[section].hasProducts?.allObjects as? [Products])
            array = array?.sorted(by: {($0.name ?? "") < ($1.name ?? "")})
            if array?.indices.contains(row) ?? false {
                return array?[row]
            }
        }
        return nil
    }
}
