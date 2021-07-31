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
                List(viewModel.listViewState.rowViewState, id: \.id) { rowViewState in
                    ZStack {
                        MainRowView(rowViewState: rowViewState)
                        NavigationLink(destination: MainDetailView(id: rowViewState.id)) {
                        }
                        .hidden()
                    }
                }
                .background(Color.clear)
            }.onAppear(perform: {
                viewModel.getQuoteReviews()
            })
            .navigationTitle("Shakespeare Reviews")
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
