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
    private let publicKey:String = "cd3d94f09ee6eaed807ab1e51d0f2acc" // "e4760158eea16317d8ca0f8b258b9b3a"
    private let privateKey:String = "defba3579ef750cdaf84d6f9ecc0420c3c16ba55" //"2afbd8d0b63f4727c6a8d0c3f240ddfcf5c89d71"
    private var ts = NSDate().timeIntervalSince1970.description
    let utilityQueue=DispatchQueue.global(qos: .utility)
    let userInitiated = DispatchQueue.global(qos: .userInitiated)
    var listComicsImagesURL:[String]=[]
    var listSeriesImagesURL:[String]=[]
    var listStoreisImagesURL:[String]=[]
    var listEventsImagesURL:[String]=[]
    /// this varible is used to post notification when it set
    private var parseIsDone:Bool?{
        didSet{
            /// push notification to reload data in first view controllet
            let notifiReload = Notification.Name(notificationForSingleDataLoad)
            NotificationCenter.default.post(name: notifiReload, object: nil)
        }
    }
    /**
     main intializer used to intialize for arrays of strings URI that will be used to get the URL information from these URI
     */
    init(comics: [String],series: [String],stores: [String],events: [String]){
        addingParameters()
        getComicStorieEventImgFromJSON(comics: comics, series: series, stores: stores, events: events)
    }
    /// this function used to add parameter requierd from MArvel API
    func addingParameters(){
        let md5Str = MD5("\(ts)\(privateKey)\(publicKey)")
        parameters = ["ts": ts ,"apikey":publicKey, "hash":md5Str.lowercased()]
    }
    /// this function will called getURL function with parameter to get url
    func getComicStorieEventImgFromJSON(comics: [String],series: [String],stores: [String],events: [String]){
        countOfAllRequeiredURL = comics.count + series.count + stores.count + events.count
        getURL(urls: comics, que: userInitiated ,flag:"comics")
        getURL(urls: series, que: utilityQueue , flag: "series")
        getURL(urls: stores, que: userInitiated, flag: "stores")
        getURL(urls: events, que: utilityQueue, flag: "events")
    }
    /// this variable will be used to detrmin when all URL is got
    var countOfAllRequeiredURL = 0
    /** this varaiable will increas each time that featch url until the end so used to post notification */
    var currentCount = 0
    /**
     this function takes three parameters first is list of Strings URI next parameter is
     que of type DispatchQueue and flage of type String to detrmin if its(comic serie story ..) que used to run the request on it
     after calling this function the result will be kist of images URL
     */
    func getURL(urls: [String] , que: DispatchQueue , flag:String){
        for url in urls {
            Alamofire.request(url, method:.get ,parameters: parameters).responseJSON(queue: que){ response in
                if let value = response.result.value {
                    let json = JSON(value)
                    var imgURL=""
                    if flag == "comics" {
                        imgURL = "\(json["data"]["results"][0]["images"][0]["path"]).\(json["data"]["results"][0]["images"][0]["extension"])"
                    }else{
                            imgURL = "\(json["data"]["results"][0]["thumbnail"]["path"]).\(json["data"]["results"][0]["thumbnail"]["extension"])"
                    }
                    self.insertToList(url :imgURL, flage: flag)
                    self.currentCount += 1
                    if self.currentCount == self.countOfAllRequeiredURL{
                        // post notification when getting all images url
                        let notifiReload = Notification.Name(notificationForSingleDataLoad)
                        NotificationCenter.default.post(name: notifiReload, object: nil)
                    }
                }
            }
        }
    }
    /**
     this function take two parameter on is url of image and othe is flage
     and based on that flag it insert url to its list flage casses {"events" or "stores" or "series" or "comics" }
     */
    func insertToList(url :String , flage: String){
        if flage == "events" {listEventsImagesURL.append(url)}
        else if flage == "stores" {listStoreisImagesURL.append(url)}
        else if flage == "series"{listSeriesImagesURL.append(url)}
        else if flage == "comics"{listComicsImagesURL.append(url)}
    }
}
