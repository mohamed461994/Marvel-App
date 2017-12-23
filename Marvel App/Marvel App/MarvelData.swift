//
//  MarvelData.swift
//  Marvel App
//
//  Created by MohamedSh on 12/22/17.
//  Copyright © 2017 MohamedSh. All rights reserved.
//

let notificationForReloadTable="reloadMarvelData"
import Foundation
import Alamofire
import SwiftHash
import SwiftyJSON
class MarvelData{
    var marvelList:[MarvelItem]=[]
    /// this varible is to detect if request is from first view controller or not
    private var requestedFromFirstViewController = true
    private var url:String?
    private var parseIsDone:Bool?{
        didSet{
            /// push notification to reload data in first view controllet
            let notifiReload = Notification.Name(notificationForReloadTable)
            NotificationCenter.default.post(name: notifiReload, object: nil)
        }
    }
    /// this varaible store parameter as dictionary of type [String:Any]
    private var parameters: Parameters?
    private var publicKey:String = "e4760158eea16317d8ca0f8b258b9b3a"
    private var privateKey:String = "2afbd8d0b63f4727c6a8d0c3f240ddfcf5c89d71"
    private var ts = NSDate().timeIntervalSince1970.description
    init(url:String ) {
        self.url = url
        addingParameters()
        getJSON()
    }
    private func getJSON(){
        let utilityQueue=DispatchQueue.global(qos: .utility)
        //print(url!,"/?ts=(ts)&apikey=\(publicKey)&hash=",MD5("\(ts)\(privateKey)\(publicKey)"))
        Alamofire.request(url!, method: .get,parameters: parameters).responseJSON(queue: utilityQueue){ response in
            if let value = response.result.value {
               let json = JSON(value)
                let result = json["data"]["results"].arrayValue
                for item in result{
                    self.marvelList.append(MarvelItem(id: item["id"].intValue,
                                  title: item["name"].stringValue,
                                  img_URL: "\(item["thumbnail"]["path"].stringValue).\(item["thumbnail"]["extension"].stringValue)",
                                  comics: self.getComicsEventsStoriesList(listJSON: item["comics"]["items"].arrayValue),
                                  series: self.getComicsEventsStoriesList(listJSON: item["series"]["items"].arrayValue),
                                  stories: self.getComicsEventsStoriesList(listJSON: item["stories"]["items"].arrayValue),
                                  events: self.getComicsEventsStoriesList(listJSON: item["events"]["items"].arrayValue)
                    ))
                }
                self.parseIsDone=true
            }
        }
    }
    func getComicsEventsStoriesList(listJSON: [JSON])->Dictionary<String,String>{
        var list:Dictionary<String,String>=[:]
        for comicStorieEvent in listJSON{
            // this line insert comic name as key to the dic and uri as value
            list[comicStorieEvent["name"].stringValue] = comicStorieEvent["resourceURI"].stringValue
        }
        return list
    }
    func addingParameters(){
           let md5Str = MD5("\(ts)\(privateKey)\(publicKey)")
        parameters = ["ts": ts ,"apikey":publicKey, "hash":md5Str.lowercased()]
        //print(ts,"   ",md5Str.lowercased())
    }
}
