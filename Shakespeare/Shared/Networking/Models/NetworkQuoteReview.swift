//
//  NetworkQuoteReview.swift
//  Shakespeare
//
//  Created by Roschaun Johnson on 7/30/21.
//

import Foundation

struct NetworkQuoteReview: Codable {

    enum CodingKeys: String, CodingKey {
        case author = "author"
        case rating = "rating"
        case publishDate = "publish_date"
        case id = "id"
        case body = "body"
    }

    var author: String?
    var rating: Float?
    var publishDate: String?
    var id: String?
    var body: String?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        author = try container.decodeIfPresent(String.self, forKey: .author)
        rating = try container.decodeIfPresent(Float.self, forKey: .rating)
        publishDate = try container.decodeIfPresent(String.self, forKey: .publishDate)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        body = try container.decodeIfPresent(String.self, forKey: .body)
    }

}

// Converts Network JSON data to Domain Data
class NetworkQuoteReviewMapper {

    class func mapToQuoteReviewModel(_ networkQuoteReview: NetworkQuoteReview) -> QuoteReview {
        var quoteReview = QuoteReview()
        quoteReview.id = networkQuoteReview.id
        quoteReview.author = networkQuoteReview.author
        quoteReview.quote = networkQuoteReview.body
        quoteReview.rating = networkQuoteReview.rating
        quoteReview.date = Date.dateFromISOString(networkQuoteReview.publishDate)
        return quoteReview
    }

    class func mapToQuoteReviewModels(_ networkQuoteReviews: [NetworkQuoteReview]) -> [QuoteReview] {
        var quoteReviews = [QuoteReview]()

        for networkQuoteReview in networkQuoteReviews {
            quoteReviews.append(mapToQuoteReviewModel(networkQuoteReview))
        }
        return quoteReviews
    }

}
