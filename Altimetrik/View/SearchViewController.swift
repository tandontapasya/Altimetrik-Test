//  Created by Tapasya on 22/08/20.
//  Copyright © 2020 Tapasya. All rights reserved.
//

import UIKit

class SearchViewController: CommonTableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchResultsTableView: UITableView!
    
    @IBOutlet weak var sortButton: UIButton!
    private var popoverManager: PopoverManager!

    private var searchViewModel: SearchViewModelType & TableViewProtocol = AlbumViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchViewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.searchResultsTableView.reloadData()
            }
        }
    }

    override func getViewModel() -> TableViewProtocol {
        return searchViewModel
    }
    
    @IBAction func navigateToCartPage(_ sender: Any) {
        guard searchViewModel.cartArray.count > 0 else {
            return
        }
        self.navigationController?.pushViewController(CartsViewController(albums: searchViewModel.cartArray), animated: true)
    }
    
    @IBAction func sortTableView(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let popoverViewController = storyboard.instantiateViewController(withIdentifier: "PopoverViewController") as? PopoverViewController else { return }
        popoverViewController.delegate = self
        popoverManager = PopoverManager(presentationController: popoverViewController, presentingViewController: self)
        popoverManager.showPopover(from: self.sortButton)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        searchViewModel.updateCartArray(at: indexPath.row,isSelected:false)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchViewModel.updateCartArray(at: indexPath.row,isSelected:true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchViewModel.query = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.endEditing(true)
    }
}

extension SearchViewController: SortingPopoverDelegate {
    func didSelectType(sortType: SortingOptions) {
        searchViewModel.sortResultsWithType(type: sortType)
    }
}
