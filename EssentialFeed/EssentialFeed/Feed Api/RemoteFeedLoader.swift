//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Dimitra Malliarou on 6/12/25.
//

import Foundation

public class RemoteFeedLoader {
    let client: HTTPClient
    let url: URL
    
    public init(url: URL, client: HTTPClient) {
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
                print("STATUS:", response.statusCode)
                print("BODY:", String(data: data, encoding: .utf8) ?? "nil")
                do {
                    let items = try FeedItemsMapper.map(data, from: response)
                    completion(items)
                }
                catch {
                    completion(.failure(Error.invalidData))
                }

            case .failure:
                completion(.failure(Error.invalidData))
            }
        }
    }
    
    public typealias Result = LoadFeedResult
        
}





