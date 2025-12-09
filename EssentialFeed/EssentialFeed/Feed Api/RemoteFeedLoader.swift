//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Dimitra Malliarou on 6/12/25.
//

import Foundation

class RemoteFeedLoader {
    let client: HTTPClient
    let url: URL
    
    init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public func load(completion: @escaping (Result) -> Void) {
        client.get(from: url) { [weak self] result in
            guard self != nil else { return }
            
            switch result {
            case let .success(data, response):
                completion(try! FeedItemsMapper.map(data, response))
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
    
    typealias Result = LoadFeedResult
        
}





