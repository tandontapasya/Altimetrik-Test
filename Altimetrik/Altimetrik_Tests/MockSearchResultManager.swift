//  Created by Tapasya on 25/08/20.
//  Copyright © 2020 Tapasya. All rights reserved.
//

import XCTest

@testable import Altemetrik

class MockSearchResultManager: XCTestCase {
    var sut: SearchResultManager?
    
    override func setUp() {
        super.setUp()
        sut = SearchResultManager()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func fetchAllAlbumsWith(query: String) -> [Album] {
        let predicateKeyword = NSPredicate(format: "artistName CONTAINS[c] %@ OR trackName CONTAINS[c] %@ OR collectionName CONTAINS[c] %@", query, query, query)

        let albums = sut!.realm.objects(Album.self).filter(predicateKeyword)
        return Array(albums)
    }
}

class MockSearchRealmManager: DatabaseManager,RealmDatabaseManager {
    
    var isFetchCalled = false
    var isCreateCalled = false
    var completeAlbums: [Album] = [Album]()

    func fetchAllAlbumsWith(query: String) -> [Album] {
        isFetchCalled = true
        return completeAlbums
    }
    
    func createAlbums(with model: [Album]) {
        isCreateCalled = true
    }
}
