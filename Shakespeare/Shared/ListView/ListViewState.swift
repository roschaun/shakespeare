//
//  ListViewState.swift
//  Shakespeare (iOS)
//
//  Created by Roschaun Johnson on 7/31/21.
//

import Foundation

struct ListViewState {
    var isLoading = true
    var showError = false
    var errorMessage: String?
    var rowViewState: [QuoteReviewViewState] = [QuoteReviewViewState]()
}

class ListViewStateReducer {

    class func reduceToState(_ quoteReviews: [QuoteReview]?) -> ListViewState {
        var listViewState = ListViewState()
        if let quoteReviews = quoteReviews {
            for quoteReview in quoteReviews {
                listViewState.rowViewState.append(QuoteReviewViewStateReducer.reduceToState(quoteReview))
            }
        }
        return listViewState
    }
}
