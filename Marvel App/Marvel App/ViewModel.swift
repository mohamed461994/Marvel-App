//
//  ViewModel.swift
//  Marvel App
//
//  Created by MohamedSh on 12/22/17.
//  Copyright © 2017 MohamedSh. All rights reserved.
//

import Foundation
class ViewModel{
    var marvelData:MarvelData?
    init(searchText:String) {
        marvelData = MarvelData(url: "http://gateway.marvel.com/v1/public/characters",searchText: searchText)
    }
    /**
     this function return count of all MArvel charchters
     */
    func marvelItemCount()-> Int{
        return (marvelData?.marvelList.count)!
    }
    /**
     this function used to get Marvel title it takes indexPath as parmeter
     */
    func marvelTite(indexPath:IndexPath)->String{
        return (marvelData?.marvelList[indexPath.row].title)!
    }
    /**
     this function used to get Marvel main image URL it takes indexPath as parmeter
     */
    func marvelURL(indexPath:IndexPath)->URL{
        return URL(string:  (marvelData?.marvelList[indexPath.row].img_URL)!)!
    }
    /**
     this function used to get Marvel ID it takes indexPath as parmeter
     */
    func marvelId(indexPath:IndexPath)->Int{
        return (marvelData?.marvelList[indexPath.row].id)!
    }
    /**
     this function used to get Marvel all data for prepare for segues process
     */
    func getSelecctedMarvelData(indexPath:IndexPath)-> MarvelItem{
        return (marvelData?.marvelList[indexPath.row])!
    }
    /**
     this function used to load new items when scroll to the End
     */
    func loadMoreData(){
        marvelData?.loadMoreData()
    }
    /**
     this function used to get all Marvels count
     */
    func numberOfRows()->Int{
        return (marvelData?.marvelList.count)!
    }
}
