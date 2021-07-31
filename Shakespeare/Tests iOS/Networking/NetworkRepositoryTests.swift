//
//  NetworkRepositoryTests.swift
//  Tests iOS
//
//  Created by Roschaun Johnson on 7/31/21.
//

import XCTest
import Combine
@testable import Shakespeare

class NetworkRepositoryTests: XCTestCase {

    var cancellables = Set<AnyCancellable>()
    var networkController: NetworkControllerProtocol = MockReviewsNetworkController()
    var networkRepository: NetworkRepositoryProtocol!
    var quoteReviews: [QuoteReview]!
    var quoteReview: QuoteReview!
    var error: Error?
    var expectation: XCTestExpectation!
    let id = "9784620626604"
    let url = URL(string: "https://shakespeare.podium.com")!

    static var filename = "NetworkQuoteReviews"

    override func setUpWithError() throws {
        cancellables = []
        networkRepository = NetworkRepository(networkController: networkController,
                                              baseUrl: url,
                                              path: "api/reviews",
                                              headers: ["x-api-key": "H3TM28wjL8R4#HTnqk?c"])

        quoteReviews = [QuoteReview]()
        quoteReview = QuoteReview()
        error = nil
        expectation = self.expectation(description: "QuoteReview")
    }

    override func tearDownWithError() throws {

    }

    func testGetQuoteReviews() throws {
        NetworkRepositoryTests.filename = "NetworkQuoteReviews"
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
        XCTAssert(quoteReviews.count == 6)
    }

    func testGetQuoteReview() throws {
        NetworkRepositoryTests.filename = "NetworkQuoteReview"
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
        NetworkRepositoryTests.filename = "NetworkQuoteReviewInvalidData"
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

class JsonUtilities {
    class func loadJsonFile(_ filename: String) -> Data? {
        let bundle = Bundle(for: NetworkRepositoryTests.self)
        if let file = bundle.path(forResource: filename, ofType: "json") {
            let jsonData = try? String(contentsOfFile: file).data(using: .utf8)
            return jsonData
        }
        return nil
    }
}

class MockReviewsNetworkController: NetworkControllerProtocol {

    func sendRequest<T>(_ request: URLRequest) -> AnyPublisher<NetworkResponse<T>, Error> where T: Decodable {
        let response = HTTPURLResponse(url: request.url!,
                                       statusCode: 200,
                                       httpVersion: "HTTP/1.1",
                                       headerFields: request.allHTTPHeaderFields)!
        let data = JsonUtilities.loadJsonFile(NetworkRepositoryTests.filename)!
        let value = try? JSONDecoder().decode(T.self, from: data)
        return Just(NetworkResponse(value: value!, response: response))
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
    }

}
