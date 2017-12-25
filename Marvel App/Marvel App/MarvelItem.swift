//
//  MarvelItem.swift
//  Marvel App
//
//  Created by MohamedSh on 12/22/17.
//  Copyright © 2017 MohamedSh. All rights reserved.
//

import Foundation
/// this struct used to represent each Marvel Item 
struct MarvelItem {
    var id:Int?
    var title:String?
    var description:String?
    var img_URL:String?
    var comics:[ComicsStoriesSeriesType]=[]
    var series:[ComicsStoriesSeriesType]=[]
    var stories:[ComicsStoriesSeriesType]=[]
    var events:[ComicsStoriesSeriesType]=[]
}
/// struct used to represent story or serie or comic or event with its URI and Title
struct ComicsStoriesSeriesType {
    var resourceURI:String?
    var name:String?
}
