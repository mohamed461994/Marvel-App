//
//  DetailesEntity+CoreDataClass.swift
//  Marvel App
//
//  Created by MohamedSh on 12/25/17.
//  Copyright © 2017 MohamedSh. All rights reserved.
//
//

import Foundation
import CoreData

@objc(DetailesEntity)
public class DetailesEntity: NSManagedObject {
    class func insertToCoreDataIfNotInserted(context: NSManagedObjectContext, title: String){
        let request: NSFetchRequest<DetailesEntity> = DetailesEntity.fetchRequest()
        request.predicate = NSPredicate(format: "title = %@", title)
        if let _ = (try? context.fetch(request).first)as? DetailesEntity{
            
        }else{
    
        }
    }
}
/*
        let request:NSFetchRequest<MarvelEntity>=MarvelEntity.fetchRequest()
        request.predicate = NSPredicate(format: "title = %@",marvelItem.title!)
        if let _ = (try? context.fetch(request).first)as? MarvelEntity{
            
        }else{
            //print("was not Aded befor")
            let marv = MarvelEntity(context: context)
            marv.id = Int64(marvelItem.id!)
            marv.detailes = marvelItem.description
            marv.imgURL = marvelItem.img_URL
            marv.title = marvelItem.title
            try? context.save()
        }
    }
 }*/
