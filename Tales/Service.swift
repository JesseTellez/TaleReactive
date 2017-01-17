//
//  Service.swift
//  Tales
//
//  Created by Jesse Tellez on 1/12/17.
//  Copyright © 2017 Tales. All rights reserved.
//


import Argo
import Foundation
import Prelude
import ReactiveSwift

public struct Service: ServiceType {
    
    public let appId: String
    public let serverConfig: ServerConfigType
    public let oauthToken: OauthTokenAuthType?
    


    public init(appID: String = Bundle.main.bundleIdentifier ?? "com.Tales.Tales",
                serverConfig: ServerConfigType = ServerConfig.local,
                authConfig: OauthTokenAuthType? = nil) {
        self.appId = appID
        self.serverConfig = serverConfig
        self.oauthToken = authConfig
    }
    
    public func fetchStories() -> SignalProducer<StoriesEnvelope, ErrorEnvelope> {
        return request(.stories)
    }
    
    private static let session = URLSession(configuration: .default)
    
    
    private func decodeModel<M: Decodable>(_ json: Any) ->
        SignalProducer<M, ErrorEnvelope> where M == M.DecodedType {
            
            return SignalProducer(value: json)
                .map { json in decode(json) as Decoded<M> }
                .flatMap(.concat) { (decoded: Decoded<M>) -> SignalProducer<M, ErrorEnvelope> in
                    switch decoded {
                    case let .success(value):
                        return .init(value: value)
                    case let .failure(error):
                        print("Argo decoding model \(M.self) error: \(error)")
                        return .init(error: .couldNotDecodeJSON(error))
                    }
            }
    }
    
    private func request<M: Decodable>(_ route: Route)
        -> SignalProducer<M, ErrorEnvelope> where M == M.DecodedType {
            
            let properties = route.requestProperties
            
            guard let URL = URL(string: properties.path, relativeTo: self.serverConfig.apiBaseUrl as URL) else {
                fatalError(
                    "URL(string: \(properties.path), relativeToURL: \(self.serverConfig.apiBaseUrl)) == nil"
                )
            }
            
            return Service.session.rac_JSONResponse(
                preparedRequest(forURL: URL, method: properties.method, query: properties.query)
                )
                .flatMap(decodeModel)
    }
    
}
