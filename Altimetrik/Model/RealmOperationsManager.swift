//  Created by Tapasya on 23/08/20.
//  Copyright © 2020 Tapasya. All rights reserved.
//

import UIKit

protocol RealmDatabaseManager {
    func fetchAllAlbumsWith(query: String) -> [Album]
    func createAlbums(with model: [Album])
}

class RealmOperationsManager: DatabaseManager,RealmDatabaseManager {
    func fetchAllAlbumsWith(query: String) -> [Album] {
        let predicateKeyword = NSPredicate(format: "artistName CONTAINS[c] %@ OR trackName CONTAINS[c] %@ OR collectionName CONTAINS[c] %@", query, query, query)

        let albums = realm.objects(Album.self).filter(predicateKeyword)
        return Array(albums)
    }
    
    func createAlbums(with model: [Album]) {
        do {
            try realm.write {
                for album in model {
                    if !doesAlbumAlreadyExists(for:album.trackId) {
                        realm.add(album)
                    }
                }
            }
        }
        catch {
        }
    }
    
    private func doesAlbumAlreadyExists(for trackId: Int) -> Bool {
        guard let _ = realm.object(ofType: Album.self, forPrimaryKey: trackId) else { return false }
        return true
    }
}
