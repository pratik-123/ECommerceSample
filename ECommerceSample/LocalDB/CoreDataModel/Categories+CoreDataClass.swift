//
//  Categories+CoreDataClass.swift
//  ECommerceSample
//
//  Created by Pratik on 20/05/20.
//  Copyright © 2020 Pratik. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Categories)
public class Categories: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case child_categories = "child_categories"
        case products = "products"
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let contextKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Categories", in: managedObjectContext) else {
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
        if let value = try? container.decodeIfPresent([Int].self, forKey: .child_categories) {
            child_categories = value
        }
        if let value = try? container.decodeIfPresent([Products].self, forKey: .products) {
            hasProducts = NSSet(array: value)
        }
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
        try container.encode(child_categories, forKey: .child_categories)
    }
}
