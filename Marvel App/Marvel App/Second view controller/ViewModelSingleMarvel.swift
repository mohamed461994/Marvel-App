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
    // comics *******************************************************
    /// this function return comics image url count
    func getComicsImgURLListCount()->Int{
        return (marveData?.listComicsImagesURL.count)!
    }
    /// this function take parameter as IndexPath and return the requeir comic img url
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
    // series *******************************************************
    /// this function return series image url count
    func getSeriesImgURLListCount()->Int{
        return (marveData?.listSeriesImagesURL.count)!
    }
    /// this function take parameter as IndexPath and return the requeir serie img url
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
    // stores *******************************************************
    /// this function return stories image url count
    func getStoriesImgURLListCount()->Int{
        return (marveData?.listStoreisImagesURL.count)!
    }
    /// this function take parameter as IndexPath and return the requeir story img url
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
    // events *******************************************************
    /// this function return events image url count
    func getEventsImgURLListCount()->Int{
        return (marveData?.listEventsImagesURL.count)!
    }
    /// this function take parameter as IndexPath and return the requeir event img url
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
