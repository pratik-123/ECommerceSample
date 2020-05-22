//
//  Rankings+CoreDataProperties.swift
//  ECommerceSample
//
//  Created by Pratik on 20/05/20.
//  Copyright © 2020 Pratik. All rights reserved.
//
//

import Foundation
import CoreData


extension Rankings {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Rankings> {
        return NSFetchRequest<Rankings>(entityName: "Rankings")
    }

    @NSManaged public var key: String?
    @NSManaged public var ranking: String?

}
