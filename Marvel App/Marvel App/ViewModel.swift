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
        marvelData = MarvelData(url: "http://gateway.marvel.com/v1/public/comics")
    }
}
