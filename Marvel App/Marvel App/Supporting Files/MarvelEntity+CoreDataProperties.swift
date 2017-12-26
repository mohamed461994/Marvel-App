//
//  MarvelEntity+CoreDataProperties.swift
//  Marvel App
//
//  Created by MohamedSh on 12/25/17.
//  Copyright © 2017 MohamedSh. All rights reserved.
//
//

import Foundation
import CoreData


extension MarvelEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MarvelEntity> {
        return NSFetchRequest<MarvelEntity>(entityName: "MarvelEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var detailes: String?
    @NSManaged public var imgURL: String?

}
