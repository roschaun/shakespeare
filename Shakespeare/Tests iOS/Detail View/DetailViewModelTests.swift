//
//  DetailViewModelTests.swift
//  Tests iOS
//
//  Created by Roschaun Johnson on 7/31/21.
//

import XCTest
import Combine
@testable import Shakespeare

class DetailViewModelTests: TestCase {

    var mainDetailViewModel: MainDetailViewModel!

    override func setupNetworkRepository(_ filename: String) {
        super.setupNetworkRepository(filename)
        mainDetailViewModel = MainDetailViewModel(networkRepository)
    }

    func testGetQuoteReviews() throws {
        setupNetworkRepository("NetworkQuoteReview")

        let statePublisher =
            mainDetailViewModel.$detailViewState
                .collect(1)
                .first()

        mainDetailViewModel.getQuoteReview(id)
        let detailViewState = try `await`(statePublisher)
        let viewState = detailViewState.first!
        XCTAssertFalse(viewState.isLoading)
        XCTAssertFalse(viewState.showError)
        XCTAssert(viewState.quoteReview.id == id)
    }

    func testGetQuoteReviewsNetworkError() throws {
        setupNetworkRepository("NetworkQuoteReviewInvalidData")

        let statePublisher =
            mainDetailViewModel.$detailViewState
                .collect(1)
                .first()

        mainDetailViewModel.getQuoteReview(id)
        let detailViewState = try `await`(statePublisher)
        let viewState = detailViewState.first!
        XCTAssertFalse(viewState.isLoading)
        XCTAssertTrue(viewState.showError)
    }

}
