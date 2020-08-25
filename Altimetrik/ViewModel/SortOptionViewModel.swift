//  Created by Tapasya on 23/08/20.
//  Copyright © 2020 Tapasya. All rights reserved.
//

import UIKit

enum SortingOptions: String {
    case collectioName = "Collection Name"
    case trackName = "Track Name"
    case artistName = "Artist Name"
    case collectionPrice = "Price"
}

protocol SortOptionViewModelType {
    var sortingOptions:[SortingOptions] { get }
}

class SortOptionViewModel: SortOptionViewModelType {
    var sortingOptions:[SortingOptions] {
        [.collectioName,.artistName,.trackName,.collectionPrice]
    }
}
