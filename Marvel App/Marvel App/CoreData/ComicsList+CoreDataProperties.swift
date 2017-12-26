//
//  ComicsList+CoreDataProperties.swift
//  Marvel App
//
//  Created by MohamedSh on 12/25/17.
//  Copyright © 2017 MohamedSh. All rights reserved.
//
//

import Foundation
import CoreData


extension ComicsList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ComicsList> {
        return NSFetchRequest<ComicsList>(entityName: "ComicsList")
    }

    @NSManaged public var image: String?
    @NSManaged public var charchter: DetailesEntity?

}
