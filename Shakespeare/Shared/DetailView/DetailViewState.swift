//
//  DetailViewState.swift
//  Shakespeare
//
//  Created by Roschaun Johnson on 7/31/21.
//

import Foundation

struct DetailViewState {
    var isLoading = true
    var showError = false
    var errorMessage: String?
    var quoteReviewState: QuoteReviewViewState = QuoteReviewViewState()
}

class DetailViewStateReducer {

    class func reduceToState(_ quoteReview: QuoteReview?) -> DetailViewState {
        var detailViewState = DetailViewState()
        detailViewState.quoteReviewState = QuoteReviewViewStateReducer.reduceToState(quoteReview)
        return detailViewState
    }
}
