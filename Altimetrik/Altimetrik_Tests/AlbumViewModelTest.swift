//  Created by Tapasya on 25/08/20.
//  Copyright © 2020 Tapasya. All rights reserved.
//

import XCTest
@testable import Altimetrik

class AlbumViewModelTest: XCTestCase {

    var sut: AlbumViewModel!
    var mockAPIService: MockSearchService!
    var mockSearchRealmManager: MockSearchRealmManager!

    override func setUp() {
        super.setUp()
        mockAPIService = MockSearchService()
        mockSearchRealmManager = MockSearchRealmManager()
        sut = AlbumViewModel(searchService: mockAPIService, searchManager: mockSearchRealmManager)
    }
    
    override func tearDown() {
        sut = nil
        mockAPIService = nil
        mockSearchRealmManager = nil
        super.tearDown()
    }

    func testFetchAlbums() {
        // Given
        mockAPIService.completeAlbums = [Album]()

        // When
        sut.performSearch()
    
        // Assert
        XCTAssert(mockAPIService!.isSearchAPICalled)
    }

    
    func testFetchAlbumsFail() {
        // Given a failed fetch with a certain failure
        let error = NSError(domain:"", code:400, userInfo:nil)

        // When
        sut.performSearch()
        
        mockAPIService.fetchFail(error: error )
    }
    
    func testSearchManagerCreateAlbumCalled() {
        goToFetchAlbumsFinished()
        XCTAssert(mockSearchRealmManager.isCreateCalled)
        XCTAssertFalse(mockSearchRealmManager.isFetchCalled)
    }

    
    func testCreateCellViewModel() {
        // Given
        let albums = StubGenerator().stubAlbums()
        mockAPIService.completeAlbums = albums
        let expect = XCTestExpectation(description: "reload closure triggered")
        sut.reloadTableViewClosure = { () in
            expect.fulfill()
        }
        
        // When
        sut.performSearch()
        mockAPIService.fetchSuccess()
        
        // Number of cell view model is equal to the number of photos
        XCTAssertEqual(sut.numberOfCells, albums.count)
        
        // XCTAssert reload closure triggered
        wait(for: [expect], timeout: 1)
    }

    func testGetCellViewModel() {
        
        //Given a sut with fetched photos
        goToFetchAlbumsFinished()
        
        let indexPath = IndexPath(row: 0, section: 0)
        mockAPIService.completeAlbums.sort(by: { (album1, album2) -> Bool in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
            guard let date1 = dateFormatter.date(from: album1.releaseDate) else { return true }
            guard let date2 = dateFormatter.date(from: album2.releaseDate) else {return true}
            return date1.compare(date2) == .orderedAscending
        })
        let album = mockAPIService.completeAlbums[indexPath.row]
        
        // When
        let viewModel = sut.getCellViewModel(at: indexPath)
        
        //Assert
        XCTAssertEqual(viewModel.trackName, album.trackName)
        XCTAssertEqual(viewModel.artworkUrl, album.artworkUrl)
        XCTAssertEqual(viewModel.artistName, album.artistName)
        XCTAssertEqual(viewModel.collectionPrice,String(album.collectionPrice))
        XCTAssertEqual(viewModel.releaseDate, album.releaseDate)
    }

    func testCellViewModel() {
        //Given albums
        let album = Album()
        album.artistName = "Gameloft"
        album.releaseDate = "2013-06-13T07:00:00Z"
        album.trackName = "Minion Rush"
        album.collectionPrice = 20.00
        album.artworkUrl = "https://is5-ssl.mzstatic.com/image/thumb/Purple124/v4/4e/6e/3b/4e6e3bfb-a6b9-b6dd-d30d-6d8136fc2f92/source/100x100bb.jpg"
        album.collectionName = "Minion"

        // When create cell view model
        let cellViewModel = sut!.createCellViewModel(album: album)

        // Assert the correctness of display information
        XCTAssertEqual(album.artistName, cellViewModel.artistName)
        XCTAssertEqual(album.trackName, cellViewModel.trackName)
        XCTAssertEqual(album.collectionName, cellViewModel.collectionName)
        XCTAssertEqual(String(album.collectionPrice),String(cellViewModel.collectionPrice))
        XCTAssertEqual(album.artworkUrl, cellViewModel.artworkUrl)
        XCTAssertEqual(album.releaseDate, cellViewModel.releaseDate)
    }
    
    func testUpdateCartArray() {
        let indexPath = IndexPath(row: 0, section: 0)
        goToFetchAlbumsFinished()
        sut.updateCartArray(at: indexPath.row, isSelected: true)
        XCTAssert(sut.cartArray.count == 1)
        sut.updateCartArray(at: indexPath.row, isSelected: false)
        XCTAssert(sut.cartArray.count == 0)
    }
    
    func testQueryString() {
        sut.query = ""
        XCTAssertFalse(mockAPIService!.isSearchAPICalled)
        sut.query = "Gameloft"
        XCTAssert(mockAPIService!.isSearchAPICalled)
    }
}

//MARK: State control
extension AlbumViewModelTest {
    private func goToFetchAlbumsFinished() {
        mockAPIService.completeAlbums = StubGenerator().stubAlbums()
        sut.performSearch()
        mockAPIService.fetchSuccess()
    }
}
