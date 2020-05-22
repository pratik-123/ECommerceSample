//
//  Rankings+CoreDataClass.swift
//  ECommerceSample
//
//  Created by Pratik on 20/05/20.
//  Copyright © 2020 Pratik. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Rankings)
public class Rankings: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case key = "key"
        case ranking = "ranking"
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let contextKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Rankings", in: managedObjectContext) else {
                fatalError("Failed to decode User")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let result = try? container.decodeIfPresent(String.self, forKey: .ranking) {
            ranking = result.toTrim
        }
        if let rankingKey = CodingUserInfoKey.rankingArray, let model = decoder.userInfo[rankingKey] as? RankingStorage {
            if let obj = model.rankings?.first(where: {($0.ranking == self.ranking)}) {
                self.key = obj.key?.toTrim
            }
        }
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(ranking, forKey: .ranking)
        try container.encode(key, forKey: .key)
    }
}
