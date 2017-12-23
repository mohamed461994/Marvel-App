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
    init() {
        marvelData = MarvelData(url: "http://gateway.marvel.com/v1/public/characters")
    }
    func marvelItemCount()-> Int{
        return (marvelData?.marvelList.count)!
    }
    func marvelTite(indexPath:IndexPath)->String{
        return (marvelData?.marvelList[indexPath.row].title)!
    }
    func marvelURL(indexPath:IndexPath)->URL{
        return URL(string:  (marvelData?.marvelList[indexPath.row].img_URL)!)!
    }
    func marvelId(indexPath:IndexPath)->Int{
        return (marvelData?.marvelList[indexPath.row].id)!
    }
    func getSelecctedMarvelData(indexPath:IndexPath)-> MarvelItem{
        return (marvelData?.marvelList[indexPath.row])!
    }

}
