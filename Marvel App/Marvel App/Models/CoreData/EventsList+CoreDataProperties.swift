//
//  EventsList+CoreDataProperties.swift
//  Marvel App
//
//  Created by MohamedSh on 12/25/17.
//  Copyright © 2017 MohamedSh. All rights reserved.
//
//

import Foundation
import CoreData


extension EventsList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EventsList> {
        return NSFetchRequest<EventsList>(entityName: "EventsList")
    }

    @NSManaged public var image: String?
    @NSManaged public var charchter: DetailesEntity?

}
