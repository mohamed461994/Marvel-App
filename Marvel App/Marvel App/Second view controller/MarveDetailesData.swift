//
//  MarveDetailesData.swift
//  Marvel App
//
//  Created by MohamedSh on 12/23/17.
//  Copyright © 2017 MohamedSh. All rights reserved.
//
let notificationForSingleDataLoad="notificationForSingleDataLoad"
import Foundation
import Alamofire
import SwiftHash
import SwiftyJSON
class SingleMarvelData{
    private var parameters: Parameters?
    private var publicKey:String = "e4760158eea16317d8ca0f8b258b9b3a"
    private var privateKey:String = "2afbd8d0b63f4727c6a8d0c3f240ddfcf5c89d71"
    private var ts = NSDate().timeIntervalSince1970.description
    let utilityQueue=DispatchQueue.global(qos: .utility)
    var listComicsImagesURL:[String]=[]
    var listSeriesImagesURL:[String]=[]
    var listStoreisImagesURL:[String]=[]
    var listEventsImagesURL:[String]=[]
    private var parseIsDone:Bool?{
        didSet{
            /// push notification to reload data in first view controllet
            let notifiReload = Notification.Name(notificationForSingleDataLoad)
            NotificationCenter.default.post(name: notifiReload, object: nil)
        }
    }
    init(comics: [String],series: [String],stores: [String],events: [String]){
        addingParameters()
    }
    func addingParameters(){
        let md5Str = MD5("\(ts)\(privateKey)\(publicKey)")
        parameters = ["ts": ts ,"apikey":publicKey, "hash":md5Str.lowercased()]
        
    }
    func getComicStorieEventImgFromJSON(urls:[String], flag:String){
        for url in urls{
            Alamofire.request(url, method:.get ,parameters: parameters).responseJSON(queue: utilityQueue){ response in
                if let value = response.result.value {
                    let json = JSON(value)
                    let imgURL = "\(json["data"]["results"][0]["images"][0]["path"]).\(json["data"]["results"][0]["images"][0]["extension"])"
                    print(imgURL)
                }
                
            }
        }
    }
}
