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
import CoreData
import Reachability
/**
  this class is used to get data from JSON it takes two parameter url and search string in case if string = "" empty text thin it wont search in case if it has value it will used for searching
 */
class MarvelData{
    var context:NSManagedObjectContext?
    var marvelList:[MarvelItem]=[]
    /// this varible is to detect if request is from first view controller or not
    private var requestedFromFirstViewController = true
    /// this variable is string url for the API
    private var url:String?
    /// this variable will set true each time json result is ready
    private var dataIsReadyToBeDisplaied:Bool?{
        didSet{
            /// push notification to reload data in first view controllet
            let notifiReload = Notification.Name(notificationForReloadTable)
            NotificationCenter.default.post(name: notifiReload, object: nil)
            /// insert to data base in case of ofline mode
            if !(MarvelData.conectionIsNotAvailable()){
                for charchter in marvelList {
                    insertToDataBase(item: charchter,context: context!)
                }
            }
            
        }
    }
    /// this variable used as parameter to API to load more data with an offset
    private var offset = 0
    /// this is parameter varible used with AlamoFire request for specific API
    private var parameters: Parameters?
    /// this is the public API key for Marvel
    private var publicKey:String = "cd3d94f09ee6eaed807ab1e51d0f2acc" // "e4760158eea16317d8ca0f8b258b9b3a"
    /// this is the private API key for Marvel
    private var privateKey:String = "defba3579ef750cdaf84d6f9ecc0420c3c16ba55" //"2afbd8d0b63f4727c6a8d0c3f240ddfcf5c89d71"
    /// this a string varible timestamp changable with time
    private var ts = NSDate().timeIntervalSince1970.description
    /// this is utility queue will be used with Alamofire reequests
    let utilityQueue=DispatchQueue.global(qos: .utility)
    init(url:String,searchText:String) {
        // in all cases you need contxt to contact with CoreData
        creatContext()
        if (MarvelData.conectionIsNotAvailable()){
            // case if there is no internet
            getDataFromDBToMarvelList()
        }else{
            // ase of online
            self.url = url
            addingParameters(searchText:searchText)
            getJSON()
        }
    }
    /**
         this function will be used to check if conection is available or not
         if not available it will return true else false
     */
        class func conectionIsNotAvailable()->Bool{
            /// checking network using reachability FramWork return true if no internet
            let reachability:Reachability = Reachability.init()!
            if ((reachability.connection) == .none){
                return true
            }
            /// checking network using AlamoFire FramWork return true if no internet
            let x = NetworkReachabilityManager()!
            if !(x.isReachable){
                return true
            }
        return false
    }
    /**
     this function is used to fill marvelList with right information by geting these INFO from the JSON response of the API it used AlamoFire for making requests
     */
    private func getJSON(){
        Alamofire.request(url!, method: .get,parameters: parameters).responseJSON(queue: utilityQueue){ response in
            if let value = response.result.value {
               let json = JSON(value)
                let result = json["data"]["results"].arrayValue
                for item in result{
                    self.marvelList.append(MarvelItem(
                        id: item["id"].intValue,
                        title: item["name"].stringValue,
                        description: item["description"].stringValue,
                        img_URL: "\(item["thumbnail"]["path"].stringValue).\(item["thumbnail"]["extension"].stringValue)",
                        comics: self.getComicsEventsStoriesList(listJSON: item["comics"]["items"].arrayValue),
                        series: self.getComicsEventsStoriesList(listJSON: item["series"]["items"].arrayValue),
                        stories: self.getComicsEventsStoriesList(listJSON: item["series"]["items"].arrayValue),
                        events: self.getComicsEventsStoriesList(listJSON: item["events"]["items"].arrayValue)
                    ))
                }
                self.dataIsReadyToBeDisplaied = true
            }
        }
    }
    /**
     this function take parmeter array of JSON wich is AlamoFire Type and return list of comics URI and Titles or Series or Stories or events by using ComicsStoriesSeriesType which is struct
     */
    func getComicsEventsStoriesList(listJSON: [JSON])->[ComicsStoriesSeriesType]{
        var list:[ComicsStoriesSeriesType]=[]
        for comicStorieEvent in listJSON{
            // this line insert comic name as key to the dic and uri as value
            list.append(ComicsStoriesSeriesType(resourceURI: comicStorieEvent["resourceURI"].stringValue ,
                name: comicStorieEvent["name"].stringValue ))
            //getComicStorieEventImagesURL(resourceURI: comicStorieEvent["resourceURI"].stringValue)
        }
        return list
    }
    /**
     this function used to load more data when user scroll down to the End
     */
    func loadMoreData(){
        offset += 6
        parameters!["offset"]=offset
        getJSON()
    }
    /** this function add requered parameters for the API and in case of searching it add a parameter for searching
     */
    func addingParameters(searchText:String){
           let md5Str = MD5("\(ts)\(privateKey)\(publicKey)")
        parameters = ["ts": ts ,"apikey":publicKey, "hash":md5Str.lowercased() ,"limit" :6 , "offset": offset]
        if searchText != ""{
            parameters!["nameStartsWith"] = searchText
            marvelList.removeAll()
        }
    }
}
extension MarvelData {
    /**
         this function take one Marvel item its class that represent each charchter com back from API
         and it will call function to store require for the first controller
     */
    func insertToDataBase(item: MarvelItem, context: NSManagedObjectContext){
        MarvelEntity.insertToCoreDataIfNotInserted(marvelItem: item, context: context)
    }
    /**
      this function is used to get shared application view context variable
     */
    func creatContext(){
        context=(UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    }
    /**
        this function will be called in case of there is no internet connection to retrive data from core data so app can work offline
     */
    func getDataFromDBToMarvelList(){
        let list = MarvelEntity.getAllDataFromCoreData(context: context!)
        for marv in list!{
             marvelList.append(MarvelItem(
                                    id: Int(marv.id),
                                    title: marv.title,
                                    description: marv.detailes,
                                    img_URL: marv.imgURL,
                                    comics: [],
                                    series: [],
                                    stories: [],
                                    events: []
                                ))
        }
        self.dataIsReadyToBeDisplaied = true
    }
}
