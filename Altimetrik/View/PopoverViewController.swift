//  Created by Tapasya on 22/08/20.
//  Copyright © 2020 Tapasya. All rights reserved.
//

import UIKit

protocol SortingPopoverDelegate {
    func didSelectType(sortType:SortingOptions)
}

class PopoverViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    var delegate: SortingPopoverDelegate?

    private var sortViewModel: SortOptionViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sortViewModel = SortOptionViewModel()
    }
    
    //MARK: UITableViewDelegate and UITableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortViewModel.sortingOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "SortTableCell") {
            cell.textLabel?.text = sortViewModel.sortingOptions[indexPath.row].rawValue
            return cell
        }
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sortType = sortViewModel.sortingOptions[indexPath.row]
        delegate?.didSelectType(sortType:sortType)
        self.dismiss(animated: true, completion: nil)
    }
}
