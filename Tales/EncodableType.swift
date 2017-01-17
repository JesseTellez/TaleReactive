//
//  EncodableType.swift
//  Tales
//
//  Created by Jesse Tellez on 1/11/17.
//  Copyright © 2017 Tales. All rights reserved.
//

import Foundation


public protocol EncodableType {
    
    func encode() -> [String: AnyObject]
    
}

public extension EncodableType {
    
    public func toJSONData() -> Data? {
        return try? JSONSerialization.data(withJSONObject: encode(), options: [])
    }
    
    public func toJSONString() -> String? {
        return self.toJSONData().flatMap { String(data: $0, encoding: .utf8)}
    }
}
