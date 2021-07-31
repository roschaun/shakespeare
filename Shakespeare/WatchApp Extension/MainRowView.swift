//
//  ContentView.swift
//  WatchApp Extension
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
            VStack(alignment: .leading) {
                Text(rowViewState.quote)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
                VStack(alignment: .leading) {
                    Text("Reviewed By:")
                        .font(.subheadline)
                    Text(rowViewState.author)
                        .font(.subheadline)
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Rating:").font(.subheadline)
                    Text(rowViewState.rating).font(.subheadline)
                }
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
