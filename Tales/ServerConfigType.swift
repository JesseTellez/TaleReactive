//
//  ServerConfigType.swift
//  Tales
//
//  Created by Jesse Tellez on 1/11/17.
//  Copyright © 2017 Tales. All rights reserved.
//

import Foundation

public protocol ServerConfigType {
    
    var apiBaseUrl: URL {get}
    
}

public struct ServerConfig: ServerConfigType {
    
    public let apiBaseUrl: URL
    
    public static let local: ServerConfigType = ServerConfig(apiBaseURL: URL(string:"localhost:5000")!)
    
    public init(apiBaseURL: URL) {
        self.apiBaseUrl = apiBaseURL
    }
}
