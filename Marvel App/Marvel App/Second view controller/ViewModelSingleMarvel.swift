
//
//  ViewModelSingleMarvel.swift
//  Marvel App
//
//  Created by MohamedSh on 12/23/17.
//  Copyright © 2017 MohamedSh. All rights reserved.
//

import Foundation
class ViewModelSingleMarvel{
    let marveData:SingleMarvelData?
    init(comics: [String],series: [String],stores: [String],events: [String]){
        marveData = SingleMarvelData(comics: comics, series: series, stores: stores, events: events)
    }
    // comics
    func getComicsImgURLListCount()->Int{
        return (marveData?.listComicsImagesURL.count)!
    }
    func getComicImgUrl(indexPath:IndexPath)->URL{
        return URL(string: (marveData?.listComicsImagesURL[indexPath.row])!)!
    }
    /**
     this function will be used to chek if all comics img url is ready or not
     it takes the requierd size and return true if img url list size is equal
     */
    func comicsListIsReady(size: Int)->Bool{
        if marveData?.listComicsImagesURL.count == size {
            return true
        }
        return false
    }
    // series
    func getSeriesImgURLListCount()->Int{
        return (marveData?.listSeriesImagesURL.count)!
    }
    func getSerieImgUrl(indexPath:IndexPath)->URL{
        return URL(string: (marveData?.listSeriesImagesURL[indexPath.row])!)!
    }
    /**
     this function will be used to chek if all series img url is ready or not
     it takes the requierd size and return true if img url list size is equal
     */
    func seriesListIsReady(size: Int)->Bool{
        if marveData?.listSeriesImagesURL.count == size {
            return true
        }
        return false
    }
    // stores
    func getStoriesImgURLListCount()->Int{
        return (marveData?.listSeriesImagesURL.count)!
    }
    func getStoryImgUrl(indexPath:IndexPath)->URL{
        return URL(string: (marveData?.listStoreisImagesURL[indexPath.row])!)!
    }
    /**
     this function will be used to chek if all stores img url is ready or not
     it takes the requierd size and return true if img url list size is equal
     */
    func storesListIsReady(size: Int)->Bool{
        if marveData?.listStoreisImagesURL.count == size {
            return true
        }
        return false
    }
    // events
    func getEventsImgURLListCount()->Int{
        return (marveData?.listEventsImagesURL.count)!
    }
    func getEventImgUrl(indexPath:IndexPath)->URL{
        return URL(string: (marveData?.listEventsImagesURL[indexPath.row])!)!
    }
    /**
     this function will be used to chek if all comics img url is ready or not
     it takes the requierd size and return true if img url list size is equal
     */
    func eventsListIsReady(size: Int)->Bool{
        if marveData?.listEventsImagesURL.count == size {
            return true
        }
        return false
    }
}
