//
//  MarvelData.swift
//  Marvel App
//
//  Created by MohamedSh on 12/22/17.
//  Copyright © 2017 MohamedSh. All rights reserved.
//

import Foundation
import Alamofire
import SwiftHash
import SwiftyJSON
class MarvelData{
    var marvelList:[MarvelItem]=[]
    /// this varible is to detect if request is from first view controller or not
    private var requestedFromFirstViewController = true
    private var url:String?
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
        print(url!,"/?ts=(ts)&apikey=\(publicKey)&hash=",MD5("\(ts)\(privateKey)\(publicKey)"))
        Alamofire.request(url!, method: .get,parameters: parameters).responseJSON(queue: utilityQueue){ response in
            if let value = response.result.value {
               let json = JSON(value)
                let result = json["data"]["results"].arrayValue
                for item in result{
                    self.marvelList.append(MarvelItem(id: item["id"].intValue,
                                             title: item["name"].stringValue,
                                             img_URL: "\(item["thumbnail"]["path"].stringValue).\(item["thumbnail"]["extension"].stringValue)"))
                }
            }
        }
    }
    func addingParameters(){
           let md5Str = MD5("\(ts)\(privateKey)\(publicKey)")
        parameters = ["ts": ts ,"apikey":publicKey, "hash":md5Str.lowercased()]
        print(ts,"   ",md5Str.lowercased())
    }
}
