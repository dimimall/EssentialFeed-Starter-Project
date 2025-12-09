//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Dimitra Malliarou on 8/12/25.
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping(HTTPClientResult) -> Void)
}
