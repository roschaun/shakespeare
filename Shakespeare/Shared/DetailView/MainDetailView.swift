//
//  MainDetailView.swift
//  Shakespeare
//
//  Created by Roschaun Johnson on 7/31/21.
//

import SwiftUI

struct MainDetailView: View {
    @ObservedObject var viewModel = MainDetailViewModel()
    let id: String

    var body: some View {
        VStack(alignment: .center) {
            Text(viewModel.detailViewState.quoteReview.quote ?? "")
        }.onAppear(perform: {
            viewModel.getQuoteReview(id)
        })
    }
}

#if DEBUG
struct MainDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MainDetailView(id: "")
    }
}
#endif
