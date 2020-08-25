//  Created by Tapasya on 25/08/20.
//  Copyright © 2020 Tapasya. All rights reserved.
//

import UIKit

class CommonTableViewController:UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    func getViewModel() -> TableViewProtocol {
        fatalError("to be implemented by subclass")
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getViewModel().numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : SearchTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let cellVM = getViewModel().getCellViewModel(at: indexPath)
        cell.albumListCellViewModel = cellVM
        return cell
    }
}
