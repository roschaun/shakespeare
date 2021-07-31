//
//  MainRowView.swift
//  Shakespeare (iOS)
//
//  Created by Roschaun Johnson on 7/31/21.
//

import SwiftUI

struct MainRowView: View {
    let rowViewState: QuoteReviewViewState

    var body: some View {
        ZStack {
            Color.theme.background.cornerRadius(12)
            RowContentView(rowViewState: rowViewState)
        }
        .fixedSize(horizontal: false, vertical: true)
        .shadow(color: Color.black.opacity(0.2),
                radius: 5,
                x: 0,
                y: 2)
    }
}

struct RowContentView: View {
    let rowViewState: QuoteReviewViewState

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(rowViewState.quote)
                    .font(.subheadline)
                    .fixedSize(horizontal: false, vertical: true)
                HStack {
                    Text("Reviewed By:")
                        .font(.caption)
                    Text(rowViewState.author)
                        .font(.caption)
                }
            }
            Spacer()
            VStack(alignment: .center) {
                Text(rowViewState.rating).font(.largeTitle)
                Text("Rating").font(.subheadline)
            }
        }
        .padding()
    }
}

#if DEBUG
struct MainRowView_Previews: PreviewProvider {
    static var previews: some View {
        MainRowView(rowViewState: QuoteReviewViewState())
    }
}
#endif
