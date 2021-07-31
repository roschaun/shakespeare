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
    var quoteReview: QuoteReview = QuoteReview()
}

class DetailViewStateReducer {

    class func reduceToState(_ quoteReview: QuoteReview?) -> DetailViewState {
        var detailViewState = DetailViewState()
        detailViewState.quoteReview = quoteReview ?? QuoteReview()
        return detailViewState
    }
}
