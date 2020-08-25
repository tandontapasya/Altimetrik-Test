//  Created by Tapasya on 24/08/20.
//  Copyright © 2020 Tapasya. All rights reserved.
//

import UIKit

class CartsViewController: CommonTableViewController {
    
    private var cartViewModel: CartViewModelType & TableViewProtocol = CartViewModel()

    init(albums:[AlbumListCellViewModel]) {
        cartViewModel.result = albums
        super.init(nibName: "CartsViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func getViewModel() -> TableViewProtocol {
        return cartViewModel
    }
}
