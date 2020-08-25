//  Created by Tapasya on 23/08/20.
//  Copyright © 2020 Tapasya. All rights reserved.
//

import UIKit
import Reachability

class NetworkManager: NSObject {

    var reachability: Reachability!
    
    static let sharedInstance: NetworkManager = { return NetworkManager() }()
    
    override init() {
        super.init()
        do {
        try reachability = Reachability.init()
        }
        catch {
            
        }
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    static func stopNotifier() -> Void {
        do {
            try (NetworkManager.sharedInstance.reachability).startNotifier()
        } catch {
            print("Error stopping notifier")
        }
    }

    static func isReachable() -> Bool {
        (NetworkManager.sharedInstance.reachability).connection != .unavailable
    }
}
