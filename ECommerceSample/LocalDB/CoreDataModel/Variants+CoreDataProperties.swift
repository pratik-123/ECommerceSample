//
//  Variants+CoreDataProperties.swift
//  ECommerceSample
//
//  Created by Pratik on 20/05/20.
//  Copyright © 2020 Pratik. All rights reserved.
//
//

import Foundation
import CoreData


extension Variants {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Variants> {
        return NSFetchRequest<Variants>(entityName: "Variants")
    }

    @NSManaged public var color: String?
    @NSManaged public var id: Int64
    @NSManaged public var price: Double
    @NSManaged public var size: Double
    @NSManaged public var belongsToProduct: Products?

}
