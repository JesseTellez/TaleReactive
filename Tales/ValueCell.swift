//
//  ValueCell.swift
//  Tales
//
//  Created by Jesse Tellez on 1/21/17.
//  Copyright © 2017 Tales. All rights reserved.
//

public protocol ValueCell: class {
    
    associatedtype Value
    static var defaultReusableId: String {get}
    func configureWith(value: Value)
    
}

