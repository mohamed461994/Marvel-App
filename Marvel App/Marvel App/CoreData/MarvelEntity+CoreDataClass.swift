//
//  MarvelEntity+CoreDataClass.swift
//  Marvel App
//
//  Created by MohamedSh on 12/25/17.
//  Copyright © 2017 MohamedSh. All rights reserved.
//
//

import Foundation
import CoreData

@objc(MarvelEntity)
public class MarvelEntity: NSManagedObject {
    /**
     this function will insert information of marvels if its not inserted befor
     */
    class func insertToCoreDataIfNotInserted(marvelItem: MarvelItem,context:NSManagedObjectContext){
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
    /**
     this function return all data from the marvel entiy
     */
    class func getAllDataFromCoreData(context:NSManagedObjectContext)->[MarvelEntity]?{
        let fetchReq:NSFetchRequest<MarvelEntity> = MarvelEntity.fetchRequest()
        if let listOfMarvData = try? context.fetch(fetchReq){
            return listOfMarvData
        }
        return nil
    }
}
