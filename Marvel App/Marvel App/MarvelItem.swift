//
//  MarvelItem.swift
//  Marvel App
//
//  Created by MohamedSh on 12/22/17.
//  Copyright © 2017 MohamedSh. All rights reserved.
//

import Foundation
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

struct ComicsStoriesSeriesType {
    var resourceURI:String?
    var name:String?
}
