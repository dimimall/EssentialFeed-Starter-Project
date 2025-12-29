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
                
                completion(RemoteFeedLoader.map(data, from: response))

            case .failure:
                completion(.failure(Error.invalidData))
            }
        }
    }
    
    private static func map(_ data: Data, from response: HTTPURLResponse) -> Result {
        do {
            let items = try FeedItemsMapper.map(data, from: response)
            return .success(items.toModels())
        }
        catch {
            return .failure(error)
        }
        
    }
    
    public typealias Result = LoadFeedResult
        
}

private extension Array where Element == RemoteFeedItem {
    func toModels() -> [FeedImage] {
        return map { FeedImage(id: $0.id, description: $0.description, location: $0.location, url: $0.image) }
    }
}



