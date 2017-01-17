//
//  StoriesEnvelope.swift
//  Tales
//
//  Created by Jesse Tellez on 1/11/17.
//  Copyright © 2017 Tales. All rights reserved.
//

import Argo
import Curry
import Runes

public struct StoriesEnvelope {
    public let stories: [Story]
}

extension StoriesEnvelope: Decodable {
    public static func decode(_ json: JSON) -> Decoded<StoriesEnvelope> {
        return curry(StoriesEnvelope.init)
        <^> json <|| "stories"
    }
}
