//
//  HelperModel.swift
//  ECommerceSample
//
//  Created by Pratik on 21/05/20.
//  Copyright © 2020 Pratik. All rights reserved.
//

import Foundation
struct CustomCodingKeys: CodingKey {
    var stringValue: String
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    var intValue: Int?
    init?(intValue: Int) {
        return nil
    }
}
struct BaseModel : Codable {
    
    let rankingsStorageModel: [RankingModel]?
    let categories: [Categories]?
    let rankings: [Rankings]?
    enum CodingKeys: String, CodingKey {
        case categories = "categories"
        case rankingsStorageModel = "rankings"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        rankingsStorageModel = try container.decodeIfPresent([RankingModel].self, forKey: .rankingsStorageModel)
        if let rankingKey = CodingUserInfoKey.rankingArray, let model = decoder.userInfo[rankingKey] as? RankingStorage {
            model.rankings = rankingsStorageModel
        }
        categories = try container.decodeIfPresent([Categories].self, forKey: .categories)
        rankings = try container.decodeIfPresent([Rankings].self, forKey: .rankingsStorageModel)
    }
}

struct RankingModel: Codable {
    let products: [ProductModel]?
    let ranking: String?
    let key: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        products = try container.decodeIfPresent([ProductModel].self, forKey: .products)
        ranking = try container.decodeIfPresent(String.self, forKey: .ranking)
        key = products?.first?.key
    }
    init(ranking: String?,key: String?) {
        self.ranking = ranking
        self.key = key
        products = nil
    }
}
struct ProductModel: Codable {
    let id: Int?
    var key: String?
    var value: Int?
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case value = "value"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        
        let keyContainer = try? (decoder.container(keyedBy: CustomCodingKeys.self))
        let dynamicKey = keyContainer?.allKeys.first(where: {($0.stringValue != CodingKeys.id.rawValue)})
        
        if let dKey = dynamicKey,let customCodeKey = CustomCodingKeys(stringValue: dKey.stringValue), let resValue = try keyContainer?.decodeIfPresent(Int.self, forKey: customCodeKey) {
            key = dKey.stringValue
            value = resValue
        } else {
            key = nil
            value = nil
        }
    }
}

class RankingStorage {
    var rankings: [RankingModel]?
}
