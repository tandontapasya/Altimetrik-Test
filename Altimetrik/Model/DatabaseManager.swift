//  Created by Tapasya on 23/08/20.
//  Copyright © 2020 Tapasya. All rights reserved.
//

import UIKit
import RealmSwift

class DatabaseManager: NSObject {
    var realm: Realm {
        get {
            do {
                let realm = try Realm()
                return realm
            }catch {
                fatalError("Database could not be initialized")
            }
        }
    }
}
