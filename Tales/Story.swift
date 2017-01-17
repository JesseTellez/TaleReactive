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
    
    public let id: Int
    public let owner_id: Int
    public let genre_id: Int
    public let title: String
    public let isTrending: Bool
    public let uniqueIndicies: Int
    public let created_at: TimeInterval
    public let updated_at: TimeInterval
    
}

extension Story: Decodable {
    
    public static func decode(_ json: JSON) -> Decoded<Story> {
        let create = curry(Story.init)
        return create
        <^> json <| "id"
        <*> json <| "owner_id"
        <*> json <| "genre_id"
        <*> json <| "title"
        <*> json <| "is_trending"
        <*> json <| "unique_indicies"
        <*> json <| "created_at"
        <*> json <| "updated_at"
    }
    
}
