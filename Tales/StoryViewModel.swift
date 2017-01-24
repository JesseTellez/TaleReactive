//
//  StoryViewModel.swift
//  Tales
//
//  Created by Jesse Tellez on 1/22/17.
//  Copyright © 2017 Tales. All rights reserved.
//

import Foundation
import Prelude
import ReactiveSwift
import Result

public protocol StoryViewModelInputs {
    
    func configureWith(story: Story)
    
}

public protocol StoryViewModelOuputs {
    
    var storyTitleLabel: Signal<String, NoError> {get}
    var storyBookmarkLabel: Signal<String, NoError> {get}
    var storyIdLabel: Signal<String, NoError> {get}
    
}

public protocol StoryViewModelType {
    var inputs: StoryViewModelInputs {get}
    var outputs: StoryViewModelOuputs {get}
    
}

//final keyword just prevents overides
public final class StoryViewModel: StoryViewModelType, StoryViewModelInputs, StoryViewModelOuputs {
    
    public init() {
        
        let story = self.storyProperty.signal.skipNil()
        
        self.storyTitleLabel = story.map {
            $0.title
        }
        
        self.storyBookmarkLabel = story.map { story -> String in
            story.number_of_bookmarks
        }
        
        self.storyIdLabel = story.map {
            $0.id
        }
        
        
    }
    
    fileprivate let storyProperty = MutableProperty<Story?>(nil)
    public func configureWith(story: Story) {
        self.storyProperty.value = story
    }
    
    public let storyIdLabel: Signal<String, NoError>
    public let storyBookmarkLabel: Signal<String, NoError>
    public let storyTitleLabel: Signal<String, NoError>
    
    public var inputs: StoryViewModelInputs {return self}
    public var outputs: StoryViewModelOuputs {return self}
    
}
