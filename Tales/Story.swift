//
//  Story.swift
//  Tales
//
//  Created by Jesse Tellez on 1/11/17.
//  Copyright © 2017 Tales. All rights reserved.
//

import Argo
import Curry
import Runes

public struct Story {
    
    public let id: String
    public let title: String
    public let number_of_bookmarks: String
    
}

extension Story: Decodable {
    
    public static func decode(_ json: JSON) -> Decoded<Story> {
        let create = curry(Story.init)
        return create
        <^> json <| "id"
        <*> json <| "title"
        <*> json <| "number_of_bookmarks"
    }
    
}


