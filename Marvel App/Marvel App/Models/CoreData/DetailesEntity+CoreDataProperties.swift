//
//  DetailesEntity+CoreDataProperties.swift
//  Marvel App
//
//  Created by MohamedSh on 12/25/17.
//  Copyright © 2017 MohamedSh. All rights reserved.
//
//

import Foundation
import CoreData


extension DetailesEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DetailesEntity> {
        return NSFetchRequest<DetailesEntity>(entityName: "DetailesEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: Int64
    @NSManaged public var serie: SeriesList?
    @NSManaged public var event: EventsList?
    @NSManaged public var story: StoriesList?
    @NSManaged public var comic: ComicsList?

}
