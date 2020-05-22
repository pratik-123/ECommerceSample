//
//  Products+CoreDataClass.swift
//  ECommerceSample
//
//  Created by Pratik on 20/05/20.
//  Copyright © 2020 Pratik. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Products)
public class Products: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case date_added = "date_added"
        case variants = "variants"
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let contextKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Products", in: managedObjectContext) else {
                fatalError("Failed to decode User")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let result = try? container.decodeIfPresent(String.self, forKey: .name) {
            name = result.toTrim
        }
        if let intValue = try? container.decodeIfPresent(Int.self, forKey: .id) {
            id = Int64(intValue)
        }
        date_added = try container.decodeIfPresent(String.self, forKey: .date_added)
        if let value = try? container.decodeIfPresent([Variants].self, forKey: .variants) {
            hasVariants = NSSet(array: value)
        }
        
        if let rankingKey = CodingUserInfoKey.rankingArray, let model = decoder.userInfo[rankingKey] as? RankingStorage {
            for ranking in (model.rankings ?? []) {
                if ranking.key == "view_count" {
                    if let obj = ranking.products?.first(where: {$0.id?.description == self.id.description}), let result = obj.value {
                        self.view_count = Int64(result)
                    }
                } else if ranking.key == "shares" {
                    if let obj = ranking.products?.first(where: {$0.id?.description == self.id.description}), let result = obj.value {
                        self.shares = Int64(result)
                    }
                } else if ranking.key == "order_count" {
                    if let obj = ranking.products?.first(where: {$0.id?.description == self.id.description}), let result = obj.value {
                        self.order_count = Int64(result)
                    }
                }
            }
        }
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
        try container.encode(date_added, forKey: .date_added)
    }
}
