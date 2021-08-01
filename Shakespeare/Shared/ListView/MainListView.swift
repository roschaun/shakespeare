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
            ZStack {
                if viewModel.listViewState.isLoading {
                    VStack(alignment: .center) {
                        ProgressView()
                    }
                }
                if viewModel.listViewState.showError {
                    VStack(alignment: .center) {
                        Text(viewModel.listViewState.errorMessage)
                        Button(NSLocalizedString("retry_label", comment: "")) {
                            viewModel.getQuoteReviews()
                        }.padding(10)
                    }.padding()
                } else {
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
                    }
                }
            }.onAppear(perform: {
                viewModel.getQuoteReviews()
            })
            .navigationTitle(NSLocalizedString("main_screen_title", comment: ""))
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
