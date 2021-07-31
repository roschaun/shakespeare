//
//  MockNetworkController.swift
//  Tests iOS
//
//  Created by Roschaun Johnson on 7/31/21.
//

import Foundation
import Combine

class MockReviewsNetworkController: NetworkControllerProtocol {

    let filename: String

    init(_ filename: String) {
        self.filename = filename
    }

    func sendRequest<T>(_ request: URLRequest) -> AnyPublisher<NetworkResponse<T>, Error> where T: Decodable {
        let response = HTTPURLResponse(url: request.url!,
                                       statusCode: 200,
                                       httpVersion: "HTTP/1.1",
                                       headerFields: request.allHTTPHeaderFields)!
        let data = JsonUtilities.loadJsonFile(filename)!
        do {
            let value = try JSONDecoder().decode(T.self, from: data)
            return Result.Publisher(NetworkResponse(value: value, response: response)).eraseToAnyPublisher()
        } catch {
            return Result.Publisher(URLError(.badServerResponse)).eraseToAnyPublisher()
        }
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
