//
//  Categories+CoreDataProperties.swift
//  ECommerceSample
//
//  Created by Pratik on 20/05/20.
//  Copyright © 2020 Pratik. All rights reserved.
//
//

import Foundation
import CoreData


extension Categories {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Categories> {
        return NSFetchRequest<Categories>(entityName: "Categories")
    }

    @NSManaged public var child_categories: [Int]?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var hasProducts: NSSet?

}

// MARK: Generated accessors for hasProducts
extension Categories {

    @objc(addHasProductsObject:)
    @NSManaged public func addToHasProducts(_ value: Products)

    @objc(removeHasProductsObject:)
    @NSManaged public func removeFromHasProducts(_ value: Products)

    @objc(addHasProducts:)
    @NSManaged public func addToHasProducts(_ values: NSSet)

    @objc(removeHasProducts:)
    @NSManaged public func removeFromHasProducts(_ values: NSSet)

}
