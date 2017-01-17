//
//  Decodable.swift
//  Tales
//
//  Created by Jesse Tellez on 1/11/17.
//  Copyright © 2017 Tales. All rights reserved.
//

import Argo

public extension Decodable {
    
    public static func decodeJSONDictionary(json: [String: AnyObject]) -> Decoded<DecodedType> {
        return Self.decode(JSON(json))
    }
    
}
