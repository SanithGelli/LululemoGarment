//
//  Garment+CoreDataProperties.swift
//  Garments
//
//  Created by Sanith on 5/27/20.
//  Copyright © 2020 Sanith. All rights reserved.
//
//

import Foundation
import CoreData


extension Garment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Garment> {
        return NSFetchRequest<Garment>(entityName: "Garment")
    }

    @NSManaged public var name: String?
    @NSManaged public var date: Date?

}
