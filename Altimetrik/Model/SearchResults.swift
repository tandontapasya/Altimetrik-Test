//  Created by Tapasya on 22/08/20.
//  Copyright © 2020 Tapasya. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class SearchResults: Codable {
    var resultCount: Int!
    var results = [Album]()
}

@objcMembers class Album: Object, Codable {
     dynamic var artistName: String!
     dynamic var trackName: String!
     dynamic var collectionName: String?
     dynamic var collectionPrice: Double = 0.00
     dynamic var releaseDate: String!
     dynamic var artworkUrl: String!
     dynamic var trackId: Int = 0

    override class func primaryKey() -> String? {
        return "trackId"
    }
    
    private enum CodingKeys: String,CodingKey {
        case artistName
        case trackName
        case collectionName
        case collectionPrice = "price"
        case releaseDate
        case artworkUrl = "artworkUrl100"
        case trackId
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.artistName = try container.decode(String.self, forKey: .artistName)
        self.trackName = try container.decode(String.self, forKey: .trackName)
        self.collectionName = try container.decodeIfPresent(String.self, forKey: .collectionName)
        self.releaseDate = try container.decode(String.self, forKey: .releaseDate)
        self.artworkUrl = try container.decode(String.self, forKey: .artworkUrl)
        self.collectionPrice = try container.decode(Double.self, forKey: .collectionPrice)
        self.trackId = try container.decode(Int.self, forKey: .trackId)

        super.init()
    }
    
    required init()
    {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema)
    {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema)
    {
        super.init(realm: realm, schema: schema)
    }
}

