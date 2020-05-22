//
//  Variants+CoreDataClass.swift
//  ECommerceSample
//
//  Created by Pratik on 20/05/20.
//  Copyright © 2020 Pratik. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Variants)
public class Variants: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case color = "color"
        case price = "price"
        case size = "size"
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let contextKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Variants", in: managedObjectContext) else {
                fatalError("Failed to decode User")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let intValue = try? container.decodeIfPresent(Int.self, forKey: .id) {
            id = Int64(intValue)
        }
        if let result = try? container.decodeIfPresent(String.self, forKey: .color) {
            color = result.toTrim
        }
        if let priceValue = try container.decodeIfPresent(Double.self, forKey: .price) {
            price = priceValue
        }
        if let sizeValue = try container.decodeIfPresent(Double.self, forKey: .size) {
            size = sizeValue
        }
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(color, forKey: .color)
        try container.encode(price, forKey: .price)
        try container.encode(size, forKey: .size)
    }
}
