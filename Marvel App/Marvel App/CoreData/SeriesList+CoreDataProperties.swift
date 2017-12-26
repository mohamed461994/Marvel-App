//
//  SeriesList+CoreDataProperties.swift
//  Marvel App
//
//  Created by MohamedSh on 12/25/17.
//  Copyright © 2017 MohamedSh. All rights reserved.
//
//

import Foundation
import CoreData


extension SeriesList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SeriesList> {
        return NSFetchRequest<SeriesList>(entityName: "SeriesList")
    }

    @NSManaged public var image: String?
    @NSManaged public var charchter: DetailesEntity?

}
