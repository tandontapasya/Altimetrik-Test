//  Created by Tapasya on 22/08/20.
//  Copyright © 2020 Tapasya. All rights reserved.
//

import UIKit

protocol CartViewModelType {
    var result: [AlbumListCellViewModel] { get set }
}

class CartViewModel: CartViewModelType,TableViewProtocol {
    var result : [AlbumListCellViewModel] = [AlbumListCellViewModel]() //0 results by default
    
    var numberOfCells: Int {
        return result.count
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> AlbumListCellViewModel {
        return result[indexPath.row]
    }
}
