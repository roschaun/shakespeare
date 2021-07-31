//
//  MainDetailViewModel.swift
//  Shakespeare
//
//  Created by Roschaun Johnson on 7/31/21.
//

import Foundation

class MainDetailViewModel: ViewModel {
    @Published var detailViewState = DetailViewState()

    func getQuoteReview(_ id: String) {
        detailViewState.isLoading = true
        cancellationToken = networkRepository.getQuoteReview(id)
            .mapError({ [weak self] (error) -> Error in
                self?.detailViewState.errorMessage = "Unable to get Quote Reviews"
                self?.detailViewState.showError = true
                self?.detailViewState.isLoading = false
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] review in
                    self?.detailViewState = DetailViewStateReducer.reduceToState(review)
                    self?.detailViewState.isLoading = false
                    self?.detailViewState.showError = false
                  })
    }
}
