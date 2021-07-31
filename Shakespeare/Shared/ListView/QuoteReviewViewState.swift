//
//  RowViewState.swift
//  Shakespeare
//
//  Created by Roschaun Johnson on 7/31/21.
//

import Foundation

struct QuoteReviewViewState {
    var id: String = UUID().uuidString
    var author: String = ""
    var rating: String = ""
    var date: String = ""
    var quote: String = ""
    var imageResource: String = "Empty"
}

class QuoteReviewViewStateReducer {

    class func reduceToState(_ quoteReview: QuoteReview?) -> QuoteReviewViewState {
        var quoteReviewViewState = QuoteReviewViewState()
        if let id = quoteReview?.id {
            quoteReviewViewState.id = id
        }
        quoteReviewViewState.quote = "\"\(quoteReview?.quote ?? "")\""
        quoteReviewViewState.author = "\(quoteReview?.author ?? "")"
        if let rating = quoteReview?.rating {
            quoteReviewViewState.rating = "\(rating)"
            switch rating {
            case 0..<2:
                quoteReviewViewState.imageResource = "WilliamShakespeareMad"
            case 2..<3.5:
                quoteReviewViewState.imageResource = "WilliamShakespeare"
            default:
                quoteReviewViewState.imageResource = "WilliamShakespeareHappy"
            }
        }
        if let date = quoteReview?.date {
            quoteReviewViewState.date = Date.stringFromDate(date)
        }
        return quoteReviewViewState
    }
}
