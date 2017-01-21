//
//  ServiceType.swift
//  Tales
//
//  Created by Jesse Tellez on 1/10/17.
//  Copyright © 2017 Tales. All rights reserved.
//

import Foundation
import Prelude
import ReactiveSwift

//A Type that knows how to preform requests for Tale Data

public protocol ServiceType {
    
    var appId: String {get}
    var serverConfig: ServerConfigType {get}
    var oauthToken: OauthTokenAuthType? { get }
    
    
    init(appID: String, serverConfig: ServerConfigType, authConfig: OauthTokenAuthType?)
    
    //
    func fetchStories() -> SignalProducer<StoriesEnvelope, ErrorEnvelope>
}

extension ServiceType {
    
    //Prepare URL Request to be sent to the server
    
    public func preparedRequest(forRequest originalRequest: URLRequest, query: [String:Any] = [:]) -> URLRequest {
        
        var request = originalRequest
        guard let URL = request.url else {
            return originalRequest
        }
        
        var headers = self.defaultHeaders
        
        let method = request.httpMethod?.uppercased()

        if method == .some("POST") || method == .some("PUT") {
            if request.httpBody == nil {
                headers["Content-Type"] = "application/json; charset=utf-8"
                request.httpBody = try? JSONSerialization.data(withJSONObject: query, options: [])
            }
        }
        
        return request
    }
    
    
    public func preparedRequest(forURL url: URL, method: Method = .GET, query: [String:Any] = [:]) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return self.preparedRequest(forRequest: request, query: query)
    }
    
    fileprivate var defaultHeaders: [String:String] {
        var headers: [String:String] = [:]
        headers["Authorization"] = self.authorizationHeader
        return headers
    }
    
    fileprivate var authorizationHeader: String? {
        if let token = self.oauthToken?.token {
            return "token \(token)"
        }
        return nil
    }
}

