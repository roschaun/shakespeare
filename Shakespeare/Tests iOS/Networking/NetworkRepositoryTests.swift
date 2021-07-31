//
//  NetworkRepositoryTests.swift
//  Tests iOS
//
//  Created by Roschaun Johnson on 7/31/21.
//

import XCTest
import Combine
@testable import Shakespeare

class NetworkRepositoryTests: TestCase {

    var cancellables = Set<AnyCancellable>()
    var quoteReviews: [QuoteReview]!
    var quoteReview: QuoteReview!
    var error: Error?
    var expectation: XCTestExpectation!

    override func setUpWithError() throws {
        cancellables = []
        quoteReviews = [QuoteReview]()
        quoteReview = QuoteReview()
        error = nil
        expectation = self.expectation(description: "QuoteReview")
    }

    func testGetQuoteReviews() throws {
        setupNetworkRepository("NetworkQuoteReviews")
        networkRepository.getQuoteReviews()
            .sink { [self] (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let encounteredError):
                    error = encounteredError
                }
                expectation.fulfill()
            } receiveValue: { [self] reviews in
                quoteReviews = reviews
            }.store(in: &cancellables)
        waitForExpectations(timeout: 10)
        XCTAssertNil(error)
        XCTAssert(quoteReviews.count == reviewCount)
    }

    func testGetQuoteReview() throws {
        setupNetworkRepository("NetworkQuoteReview")
        networkRepository.getQuoteReview(id)
            .sink { [self] (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let encounteredError):
                    error = encounteredError
                }
                expectation.fulfill()
            } receiveValue: { [self] review in
                quoteReview = review
            }.store(in: &cancellables)
        waitForExpectations(timeout: 10)
        XCTAssertNil(error)
        XCTAssert(quoteReview.id == id)
        XCTAssert(quoteReview.rating == 4.1)
    }

    func testGetQuoteReviewInvalidData() throws {
        setupNetworkRepository("NetworkQuoteReviewInvalidDate")
        networkRepository.getQuoteReview(id)
            .sink { [self] (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let encounteredError):
                    error = encounteredError
                }
                expectation.fulfill()
            } receiveValue: { [self] review in
                quoteReview = review
            }.store(in: &cancellables)
        waitForExpectations(timeout: 10)
        XCTAssertNil(error)
        XCTAssert(quoteReview.id == id)
        XCTAssert(quoteReview.date == nil)
        XCTAssert(quoteReview.rating == 4.1)
    }

    func testNetworkGetQuoteReviews() throws {
        networkRepository = NetworkRepository(networkController: NetworkController(),
                                              baseUrl: url,
                                              path: "api/reviews",
                                              headers: ["x-api-key": "H3TM28wjL8R4#HTnqk?c"])
        networkRepository.getQuoteReviews()
            .sink { [self] (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let encounteredError):
                    error = encounteredError
                }
                expectation.fulfill()
            } receiveValue: { [self] reviews in
                quoteReviews = reviews
            }.store(in: &cancellables)
        waitForExpectations(timeout: 10)
        XCTAssertNil(error)
        XCTAssert(quoteReviews.count > 0)
    }
}
