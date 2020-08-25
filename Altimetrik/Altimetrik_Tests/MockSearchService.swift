//  Created by Tapasya on 25/08/20.
//  Copyright © 2020 Tapasya. All rights reserved.
//

import XCTest
@testable import Altemetrik

class MockSearchService: SearchServiceProtocol {
    var isSearchAPICalled = false

    var completeClosure: (([Album]?, Error?) -> ())!
    var completeAlbums: [Album] = [Album]()

    func search(query: String, completionHandler: @escaping ([Album]?, Error?) -> Void) {
        isSearchAPICalled = true
        completeClosure = completionHandler
    }
    
    func fetchSuccess() {
        completeClosure(completeAlbums, nil )
    }
    
    func fetchFail(error: Error?) {
        completeClosure( nil, error )
    }
}

class StubGenerator {
    func stubAlbums() -> [Album] {
        let path = Bundle.main.path(forResource: "Content", ofType: "txt")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let photos = try! decoder.decode(SearchResults.self, from: data)
        return photos.results
    }
}
