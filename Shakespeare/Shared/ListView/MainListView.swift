//
//  MainListView.swift
//  Shakespeare (iOS)
//
//  Created by Roschaun Johnson on 7/31/21.
//

import SwiftUI
import Combine

struct MainListView: View {
    @ObservedObject var viewModel = MainListViewModel()

    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.listViewState.quoteReviews, id: \.id) { quoteReview in
                    MainRowView(quoteReview: quoteReview)
                }
            }.onAppear(perform: {
                viewModel.getQuoteReviews()
            })
            .navigationTitle("Shakespeare")
        }
    }
}

#if DEBUG
struct MainListView_Previews: PreviewProvider {
    static var previews: some View {
        MainListView()
    }
}
#endif
