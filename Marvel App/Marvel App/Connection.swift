//
//  Connection.swift
//  Marvel App
//
//  Created by MohamedSh on 12/25/17.
//  Copyright © 2017 MohamedSh. All rights reserved.
//

import Foundation
import Reachability
struct Connection{
    static func isNotAvailable()->Bool{
        let reachability = Reachability.init()
        if (reachability?.connection == .none){
            return true
        }
        return false
    }
}
