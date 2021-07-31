//
//  TestCase.swift
//  Tests iOS
//
//  Created by Roschaun Johnson on 7/31/21.
//

import XCTest
@testable import Shakespeare

class TestCase: XCTestCase {

    var networkController: NetworkControllerProtocol = MockReviewsNetworkController("NetworkQuoteReviews")
    var networkRepository: NetworkRepositoryProtocol!
    let url = URL(string: "https://shakespeare.podium.com")!
    let reviewCount = 6

    func setupNetworkRepository(_ filename: String) {
        networkController = MockReviewsNetworkController(filename)
        networkRepository = NetworkRepository(networkController: networkController,
                                              baseUrl: url,
                                              path: "api/reviews",
                                              headers: ["x-api-key": "H3TM28wjL8R4#HTnqk?c"])
    }

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }
}
