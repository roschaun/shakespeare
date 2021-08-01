//
//  MainListViewModel.swift
//  Shakespeare (iOS)
//
//  Created by Roschaun Johnson on 7/31/21.
//

import Foundation
import Combine

class MainListViewModel: ViewModel {
    @Published var listViewState = ListViewState()

    func getQuoteReviews() {
        listViewState.isLoading = true
        cancellationToken = networkRepository.getQuoteReviews()
            .mapError({ [weak self] (error) -> Error in
                self?.listViewState.showError = true
                self?.listViewState.isLoading = false
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] reviews in
                    self?.listViewState = ListViewStateReducer.reduceToState(reviews)
                    self?.listViewState.isLoading = false
                    self?.listViewState.showError = false
                  })
    }
}
