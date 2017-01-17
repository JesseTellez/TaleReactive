//
//  Route.swift
//  Tales
//
//  Created by Jesse Tellez on 1/11/17.
//  Copyright © 2017 Tales. All rights reserved.
//

import Prelude


internal enum Route {
    
    case stories
    
    internal var requestProperties: (method: Method, path: String, query: [String:Any], file: String?) {
        
        switch self {
        case .stories:
            return (.GET, "/stories", [:], nil)
        }
    }
    
}
