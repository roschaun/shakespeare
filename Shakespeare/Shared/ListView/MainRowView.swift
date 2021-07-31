//
//  MainRowView.swift
//  Shakespeare (iOS)
//
//  Created by Roschaun Johnson on 7/31/21.
//

import SwiftUI

struct MainRowView: View {
    let quoteReview: QuoteReview

    var body: some View {
        VStack(alignment: .center) {
            Text(quoteReview.quote ?? "")
        }
    }
}

#if DEBUG
struct MainRowView_Previews: PreviewProvider {
    static var previews: some View {
        MainRowView(quoteReview: QuoteReview())
    }
}
#endif
