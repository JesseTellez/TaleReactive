//
//  StoriesViewModel.swift
//  Tales
//
//  Created by Jesse on 1/16/17.
//  Copyright © 2017 Tales. All rights reserved.
//

import Foundation
import Prelude
import ReactiveSwift
import Result


public protocol StoriesViewModelInputs {
    
    func reactiveButtonPressed()
    
}

public protocol StoriesViewModelOutputs {
    
    //Emits an array of stories that should be displayed
    var stories: Signal<[Story], NoError> { get }
    func userSessionStarted()
    func viewWillAppear(animated: Bool)
    
}

public protocol StoriesViewModelType {
    
    var inputs: StoriesViewModelInputs { get }
    var outputs: StoriesViewModelOutputs { get }
    
}

public final class StoriesViewModel: StoriesViewModelType, StoriesViewModelInputs, StoriesViewModelOutputs {
    
    public func reactiveButtonPressed() {
        
    }
    

    public var inputs: StoriesViewModelInputs {return self}
    public var outputs: StoriesViewModelOutputs {return self}
    public let stories: Signal<[Story], NoError>
    
    fileprivate let viewWillAppearProperty = MutableProperty<Bool?>(nil)
    public func viewWillAppear(animated: Bool) {
        self.viewWillAppearProperty.value = animated
    }
    fileprivate let userSessionStartedProperty = MutableProperty(())
    public func userSessionStarted() {
        self.userSessionStartedProperty.value = ()
    }
    
    public init() {
        
        
        //Signal<[Story], NoError>
        //SignalProducer<StoriesEnvelope, ErrorEnvelope>
        // map each story in the story envelope (evelope in to a signal of the story array)
        
        let firstLoad = Signal.merge(self.userSessionStartedProperty.signal)
        
        let stories2 = firstLoad.flatMap {
            _  -> SignalProducer<[Story], NoError> in
            return ENV.apiService.fetchStories().map {$0.stories}.demoteErrors()
        }.skip(first: 0)
        
        
        self.stories = stories2
  
        
    }
}
