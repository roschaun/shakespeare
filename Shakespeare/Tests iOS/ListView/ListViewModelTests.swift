//
//  ListViewModelTests.swift
//  Tests iOS
//
//  Created by Roschaun Johnson on 7/31/21.
//

import XCTest
import Combine
@testable import Shakespeare

class ListViewModelTests: TestCase {

    var mainListViewModel: MainListViewModel!

    override func setupNetworkRepository(_ filename: String) {
        super.setupNetworkRepository(filename)
        mainListViewModel = MainListViewModel(networkRepository)
    }

    func testGetQuoteReviews() throws {
        setupNetworkRepository("NetworkQuoteReviews")

        let statePublisher =
            mainListViewModel.$listViewState
                .collect(1)
                .first()

        mainListViewModel.getQuoteReviews()
        let listViewState = try `await`(statePublisher)
        let viewState = listViewState.first!
        XCTAssertFalse(viewState.isLoading)
        XCTAssertFalse(viewState.showError)
        XCTAssert(viewState.rowViewState.count == reviewCount)
    }

    func testGetQuoteReviewsNetworkError() throws {
        setupNetworkRepository("NetworkQuoteReviewsInvalidData")

        let statePublisher =
            mainListViewModel.$listViewState
                .collect(1)
                .first()

        mainListViewModel.getQuoteReviews()
        let listViewState = try `await`(statePublisher)
        let viewState = listViewState.first!
        XCTAssertFalse(viewState.isLoading)
        XCTAssertTrue(viewState.showError)
    }

}
