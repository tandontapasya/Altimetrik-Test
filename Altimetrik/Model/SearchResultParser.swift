//  Created by Tapasya on 22/08/20.
//  Copyright © 2020 Tapasya. All rights reserved.
//

import UIKit

class SearchResultParser: NSObject {
    func parseSearchResults(searchResultData: Data) -> SearchResults? {
        guard let dict = try? JSONDecoder().decode(SearchResults.self, from: searchResultData) else { return nil }
        return dict
    }
}
