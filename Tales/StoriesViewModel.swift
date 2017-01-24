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
    
    func willDisplayRow(_ row: Int, outOf totalRows: Int)
    
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
    fileprivate let willDisplayRowProperty = MutableProperty<(row: Int, total: Int)?>(nil)
    public func willDisplayRow(_ row: Int, outOf totalRows: Int) {
        self.willDisplayRowProperty.value = (row, totalRows)
    }
    
    public init() {
        
        let firstLoad = Signal.merge(self.userSessionStartedProperty.signal)
        
        let stories2 = firstLoad.flatMap {
            _  -> SignalProducer<[Story], NoError> in
            return ENV.apiService.fetchStories().map {$0.stories}.demoteErrors()
        }.skip(first: 0).logEvents()
        
        
        self.stories = stories2
  
        
    }
}
