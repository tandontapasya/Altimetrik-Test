//  Created by Tapasya on 25/08/20.
//  Copyright © 2020 Tapasya. All rights reserved.
//

import XCTest
@testable import Altimetrik

class SearchResultsTest: XCTestCase {

    func testDecodedSuccessfully() throws {
        let decoder = JSONDecoder()
        let data = Data("{\"artistName\": \"Gameloft\",\"trackName\": \"Minion Rush\",\"collectionName\": \"Minion\",\"price\": 0.00,\"artworkUrl100\": \"https://is5-ssl.mzstatic.com/image/thumb/Purple124/v4/4e/6e/3b/4e6e3bfb-a6b9-b6dd-d30d-6d8136fc2f92/source/100x100bb.jpg\",\"releaseDate\": \"2013-06-13T07:00:00Z\",\"trackId\": 123456}".utf8)
        let container = try decoder.decode(Album.self, from: data)
        XCTAssertEqual(container.artistName,"Gameloft")
        XCTAssertEqual(container.trackName,"Minion Rush")
        XCTAssertEqual(container.collectionName,"Minion")
        XCTAssertEqual(container.collectionPrice,0.00)
        XCTAssertEqual(container.artworkUrl,"https://is5-ssl.mzstatic.com/image/thumb/Purple124/v4/4e/6e/3b/4e6e3bfb-a6b9-b6dd-d30d-6d8136fc2f92/source/100x100bb.jpg")
        XCTAssertEqual(container.releaseDate,"2013-06-13T07:00:00Z")
        XCTAssertEqual(container.trackId,123456)
    }
}


