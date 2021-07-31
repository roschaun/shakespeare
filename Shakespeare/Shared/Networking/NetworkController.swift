//
//  NetworkController.swift
//  Shakespeare
//
//  Created by Roschaun Johnson on 7/30/21.
//

import Foundation
import Combine

protocol NetworkControllerProtocol {
    func sendRequest<T: Decodable>(_ request: URLRequest) -> AnyPublisher<NetworkResponse<T>, Error>
}

struct NetworkResponse<T> {
    let value: T
    let response: URLResponse
}

enum NetworkError: LocalizedError {
    case statusCode
}

class NetworkController: NetworkControllerProtocol {

    func sendRequest<T: Decodable>(_ request: URLRequest) -> AnyPublisher<NetworkResponse<T>, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> NetworkResponse<T> in
                let value = try JSONDecoder().decode(T.self, from: result.data)
                return NetworkResponse(value: value, response: result.response)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
