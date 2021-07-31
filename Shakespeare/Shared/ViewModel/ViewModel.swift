//
//  ViewModel.swift
//  Shakespeare (iOS)
//
//  Created by Roschaun Johnson on 7/31/21.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    var cancellationToken: AnyCancellable?

    let networkRepository: NetworkRepositoryProtocol

    init(_ networkRepository: NetworkRepositoryProtocol = NetworkRepository(
            baseUrl: URL(string: "https://shakespeare.podium.com")!,
            path: "api/reviews",
            headers: ["x-api-key": "H3TM28wjL8R4#HTnqk?c"])) {
        self.networkRepository = networkRepository
    }
}
