//
//  DataMediator+CoreDataHelper.swift
//  ECommerceSample
//
//  Created by Pratik on 21/05/20.
//  Copyright © 2020 Pratik. All rights reserved.
//

import CoreData

extension DataMediator {
    
    /// Store category data in local db
    /// - Parameters:
    ///   - categoryData: response data
    ///   - completionHandler: completion block
    func storeCategoryData(categoryData: Data, completionHandler:@escaping ((_ isSuccess: Bool,_ message: String?) -> Void)) {
        CoreDataManager.shared.persistentContainer.performBackgroundTask { (managedObjectContext) in
            managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            let decoder = JSONDecoder()
            if let context = CodingUserInfoKey.context {
                decoder.userInfo[context] = managedObjectContext
            }
            if let rankingKey = CodingUserInfoKey.rankingArray {
                decoder.userInfo[rankingKey] = RankingStorage()
            }
            do {
                _ = try decoder.decode(BaseModel.self, from: categoryData)
                try managedObjectContext.save()
                if managedObjectContext.hasChanges {
                    try managedObjectContext.save()
                }
                completionHandler(true, nil)
            } catch {
                print(error)
                completionHandler(false, error.localizedDescription)
            }
        }
    }
    
    /// Category data get from local db
    /// - Returns: array of categories
    func getCategoriesData() -> [Categories] {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let name = String(describing: Categories.self)
        let arrayOfData = context.fetchData(entityName: name)
        if let array = arrayOfData as? [Categories] {
            return array
        }
        return []
    }
    
    /// Ranking data get
    /// - Returns: array of rankigs data
    func getRankingsData() -> [Rankings] {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let name = String(describing: Rankings.self)
        let arrayOfData = context.fetchData(entityName: name)
        if let array = arrayOfData as? [Rankings] {
            return array
        }
        return []
    }
}
