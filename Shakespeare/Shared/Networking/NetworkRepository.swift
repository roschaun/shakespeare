//
//  NetworkRepository.swift
//  Shakespeare
//
//  Created by Roschaun Johnson on 7/30/21.
//

import Foundation
import Combine

protocol NetworkRepositoryProtocol {
    func getQuoteReviews() -> AnyPublisher<[QuoteReview], Error>
    func getQuoteReview(_ id: String) -> AnyPublisher<QuoteReview, Error>
}

class NetworkRepository: NetworkRepositoryProtocol {

    let networkController: NetworkControllerProtocol
    let baseUrl: URL
    let path: String
    let headers: [String: String]

    init(networkController: NetworkControllerProtocol = NetworkController(),
         baseUrl: URL,
         path: String,
         headers: [String: String]) {
        self.networkController = networkController
        self.baseUrl = baseUrl
        self.path = path
        self.headers = headers
    }

    func getRequest(_ components: URLComponents) -> URLRequest? {
        guard let url = components.url else {
            return nil
        }
        var request = URLRequest(url: url)
        for (key, value) in headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
        return request
    }

    func getQuoteReviews() -> AnyPublisher<[QuoteReview], Error> {
        guard let components =
                URLComponents(url: baseUrl.appendingPathComponent(path), resolvingAgainstBaseURL: true),
              let request = getRequest(components)
        else {
            fatalError("Couldn't create URLComponents")
        }
        return networkController.sendRequest(request)
            .map {
                NetworkQuoteReviewMapper.mapToQuoteReviewModels($0.value)
            }.eraseToAnyPublisher()
    }

    func getQuoteReview(_ id: String) -> AnyPublisher<QuoteReview, Error> {
        guard let components =
                URLComponents(url: baseUrl.appendingPathComponent("\(path)/\(id)"), resolvingAgainstBaseURL: true),
              let request = getRequest(components)
        else {
            fatalError("Couldn't create URLComponents")
        }
        return networkController.sendRequest(request)
            .map {
                NetworkQuoteReviewMapper.mapToQuoteReviewModel($0.value)
            }.eraseToAnyPublisher()
    }

}
