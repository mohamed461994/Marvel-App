
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
    // series
    func getSeriesImgURLListCount()->Int{
        return (marveData?.listSeriesImagesURL.count)!
    }
    func getSerieImgUrl(indexPath:IndexPath)->URL{
        return URL(string: (marveData?.listSeriesImagesURL[indexPath.row])!)!
    }
    // stores
    func getStoriesImgURLListCount()->Int{
        return (marveData?.listSeriesImagesURL.count)!
    }
    func getStoryImgUrl(indexPath:IndexPath)->URL{
        return URL(string: (marveData?.listStoreisImagesURL[indexPath.row])!)!
    }
    // events
    func getEventsImgURLListCount()->Int{
        return (marveData?.listEventsImagesURL.count)!
    }
    func getEventImgUrl(indexPath:IndexPath)->URL{
        return URL(string: (marveData?.listEventsImagesURL[indexPath.row])!)!
    }
}
