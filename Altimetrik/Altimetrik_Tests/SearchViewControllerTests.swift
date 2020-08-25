//  Created by Tapasya on 25/08/20.
//  Copyright © 2020 Tapasya. All rights reserved.
//

import XCTest
@testable import Altimetrik

class SearchViewControllerTests: XCTestCase {
    
    func makeSUT() -> SearchViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(identifier: "SearchViewController") as! SearchViewController
        sut.loadViewIfNeeded()
        return sut
    }
    
    func testViewDidLoad() {
        let sut = makeSUT()
        sut.viewDidLoad()
        
        XCTAssertNotNil(sut.searchResultsTableView, "table view instance should be present")
        XCTAssertNotNil(sut.searchBar, "search bar instance should be present")
        XCTAssertNotNil(sut.sortButton, "sort button instance should be present")
    }
}
