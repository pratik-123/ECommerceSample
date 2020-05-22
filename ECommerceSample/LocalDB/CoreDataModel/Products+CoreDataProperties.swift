//
//  Products+CoreDataProperties.swift
//  ECommerceSample
//
//  Created by Pratik on 20/05/20.
//  Copyright © 2020 Pratik. All rights reserved.
//
//

import Foundation
import CoreData


extension Products {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Products> {
        return NSFetchRequest<Products>(entityName: "Products")
    }

    @NSManaged public var date_added: String?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var order_count: Int64
    @NSManaged public var shares: Int64
    @NSManaged public var view_count: Int64
    @NSManaged public var belongsToCategories: Categories?
    @NSManaged public var hasTax: NSSet?
    @NSManaged public var hasVariants: NSSet?

}

// MARK: Generated accessors for hasTax
extension Products {

    @objc(addHasTaxObject:)
    @NSManaged public func addToHasTax(_ value: Tax)

    @objc(removeHasTaxObject:)
    @NSManaged public func removeFromHasTax(_ value: Tax)

    @objc(addHasTax:)
    @NSManaged public func addToHasTax(_ values: NSSet)

    @objc(removeHasTax:)
    @NSManaged public func removeFromHasTax(_ values: NSSet)

}

// MARK: Generated accessors for hasVariants
extension Products {

    @objc(addHasVariantsObject:)
    @NSManaged public func addToHasVariants(_ value: Variants)

    @objc(removeHasVariantsObject:)
    @NSManaged public func removeFromHasVariants(_ value: Variants)

    @objc(addHasVariants:)
    @NSManaged public func addToHasVariants(_ values: NSSet)

    @objc(removeHasVariants:)
    @NSManaged public func removeFromHasVariants(_ values: NSSet)

}
