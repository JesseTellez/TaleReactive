//
//  Environment.swift
//  Tales
//
//  Created by Jesse on 1/16/17.
//  Copyright © 2017 Tales. All rights reserved.
//

import Foundation
import AVFoundation
import ReactiveSwift
import Result


public struct Environment {
    
    public let apiService: ServiceType
    
    public init() {
        self.apiService = Service()
    }
    
}

public let ENV = Environment()
