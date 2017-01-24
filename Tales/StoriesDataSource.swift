//
//  StoriesDataSource.swift
//  Tales
//
//  Created by Jesse Tellez on 1/21/17.
//  Copyright © 2017 Tales. All rights reserved.
//

import Prelude
import UIKit

internal final class StoriesDataSource: ValueCellDataSource {
    
    
    //use this once I want to use sections in my table
    internal enum Section: Int {
        case stories
    }
    
    internal func load(stories: [Story]) {
        
        stories.forEach { story in
            self.appendRow(value: story, cellClass: StoriesFeedCell.self)
        }
    }
    
    override func configureCell(tableCell cell: UITableViewCell, withValue value: Any) {
        switch (cell, value) {
        case let (cell as StoriesFeedCell, story as Story):
            cell.configureWith(value: story)
        default:
            assertionFailure()
        }
    }
    
    
    
}
