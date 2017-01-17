//
//  OauthTokenAuthType.swift
//  Tales
//
//  Created by Jesse Tellez on 1/11/17.
//  Copyright © 2017 Tales. All rights reserved.
//

public protocol OauthTokenAuthType {
    
    var token: String {get}
    
}

public struct OauthToken: OauthTokenAuthType {
    public let token: String
    public init(token: String) {
        self.token = token
    }
}
