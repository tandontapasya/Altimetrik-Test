//  Created by Tapasya on 25/08/20.
//  Copyright © 2020 Tapasya. All rights reserved.
//

import XCTest
@testable import Altemetrik

class SearchServiceTest: XCTestCase {

    var sut: SearchService?
     
     override func setUp() {
         super.setUp()
         sut = SearchService()
     }

     override func tearDown() {
         sut = nil
         super.tearDown()
     }

     func testFetchAlbums() {
         let sut = self.sut!
         let expect = XCTestExpectation(description: "callback")

        sut.search(query: "Gameloft") { (albums, error) in
            expect.fulfill()
            XCTAssertNil(error)
            XCTAssertEqual(albums?.count, 39)
            for album in albums! {
                XCTAssertNotNil(album.artistName)
                XCTAssertNotNil(album.trackName)
                XCTAssertNotNil(album.releaseDate)
                XCTAssertNotNil(album.collectionPrice)
            }
        }
         wait(for: [expect], timeout: 200)
     }
}
