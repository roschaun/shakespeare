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
    var quoteReviews: [QuoteReview] = [QuoteReview]()
}

class ListViewStateReducer {

    class func reduceToState(_ quoteReviews: [QuoteReview]?) -> ListViewState {
        var listViewState = ListViewState()
        listViewState.quoteReviews = quoteReviews ?? [QuoteReview]()
        return listViewState
    }
}
