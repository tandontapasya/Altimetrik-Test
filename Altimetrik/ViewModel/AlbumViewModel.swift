//  Created by Tapasya on 22/08/20.
//  Copyright © 2020 Tapasya. All rights reserved.
//

import UIKit

protocol TableViewProtocol {
    var numberOfCells: Int { get }
    func getCellViewModel( at indexPath: IndexPath ) -> AlbumListCellViewModel
}
protocol SearchViewModelType : class {
    var query: String { get set }
    var cartArray: [AlbumListCellViewModel] { get set}
    
    func sortResultsWithType(type:SortingOptions)
    func updateCartArray(at index:Int, isSelected:Bool)
    var reloadTableViewClosure: (()->())? { get set }
}

/// View model for SearchViewController
class AlbumViewModel: SearchViewModelType,TableViewProtocol {
    var reloadTableViewClosure: (()->())?
    
    /// array to be shown in CartViewController
    var cartArray = [AlbumListCellViewModel]()
    private var result : [Album]?
    
    let searchService: SearchServiceProtocol
    
    // realm manager to store and fetch data from local db
    let realmManager: RealmDatabaseManager
    
    init(searchService: SearchServiceProtocol = SearchService(), searchManager: RealmDatabaseManager = RealmOperationsManager()) {
        self.searchService = searchService
        self.realmManager = searchManager
    }
    
    
    /// View model for SearchTableViewCell
    private var cellViewModels: [AlbumListCellViewModel] = [AlbumListCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    /// Get AlbumListCellViewModel at Index Path
    /// - Parameter indexPath: index path
    /// - Returns:  AlbumListCellViewModel
    func getCellViewModel(at indexPath: IndexPath) -> AlbumListCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func createCellViewModel(album: Album) -> AlbumListCellViewModel {
        return AlbumListCellViewModel(releaseDate: album.releaseDate, collectionName:album.collectionName ?? "", trackName: album.trackName, artistName: album.artistName, collectionPrice: String(album.collectionPrice), artworkUrl: album.artworkUrl)
    }
    
    /// Sort and remove duplicate Albums fetched from sever
    /// - Parameter indexPath: index path
    /// - Returns: AlbumListCellViewModel
    private func processFetchedAlbums(albums: [Album]) {
        self.result = (albums.unique { $0.trackId })
        self.result?.sort(by: { (album1, album2) -> Bool in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
            guard let date1 = dateFormatter.date(from: album1.releaseDate) else { return true }
            guard let date2 = dateFormatter.date(from: album2.releaseDate) else {return true}
            return date1.compare(date2) == .orderedAscending
        })
        self.realmManager.createAlbums(with: (self.result!))
        createCellViewModelArray()
    }
    
    func createCellViewModelArray() {
        var cellViewModel = [AlbumListCellViewModel]()
        for album in self.result! {
            cellViewModel.append(self.createCellViewModel(album: album))
        }
        self.cellViewModels = cellViewModel
    }
    
    /// term to be searched
    var query: String = "" {
        didSet {
            if self.query == "" {
                self.cellViewModels = []
            }else {
                self.performSearch()
            }
        }
    }
    
    /// call search api if internet connection is available or fetch data from local db if no internet
    func performSearch() {
        if !NetworkManager.isReachable() {
            self.result = self.realmManager.fetchAllAlbumsWith(query: self.query)
            createCellViewModelArray()
        }
        else {
            searchService.search(query: self.query, completionHandler: { [weak self] (results, error) in
                guard let weakSelf = self, let searchResults = results else { return }
                weakSelf.processFetchedAlbums(albums: searchResults)
            })
        }
    }
    
    
    /// Add/remove from Cart array if selected/deselected
    /// - Parameters:
    ///   - index: index path
    ///   - isSelected: if row is selected/deselected at index path
    func updateCartArray(at index:Int, isSelected:Bool) {
        guard cellViewModels.count > 0 else {
            
            return
        }
        let album =  cellViewModels[index]
        if isSelected {
            cartArray.append(album)
        }
        else {
            cartArray.removeObject(obj:album)
        }
    }
    
    
    /// Sort albums based on selected type
    /// - Parameter type: Sorting options e.g. "artist name", "track name"
    func sortResultsWithType(type:SortingOptions) {
        switch type {
        case .artistName:
            cellViewModels.sort(by: { $0.artistName.compare($1.artistName) == .orderedAscending })
        case .trackName:
            cellViewModels.sort(by: { $0.trackName.compare($1.trackName) == .orderedAscending })
        case .collectionPrice:
            cellViewModels.sort(by: { $0.collectionPrice > ($1.collectionPrice) })
        case .collectioName:
            cellViewModels.sort(by: { (first, second) -> Bool in
                first.collectionName.compare(second.collectionName) == .orderedAscending
            })
        }
    }
}


