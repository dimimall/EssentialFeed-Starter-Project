//
//  Copyright © Essential Developer. All rights reserved.
//

import Foundation

public enum LoadFeedResult {
	case success([FeedItem])
	case failure(Error)
}

//extension LoadFeedResult: Equatable where Error: Equatable {}

public protocol FeedLoader {
	func load(completion: @escaping (LoadFeedResult) -> Void)
}
