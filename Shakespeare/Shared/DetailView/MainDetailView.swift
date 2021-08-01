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
        ZStack {
            if viewModel.detailViewState.isLoading {
                VStack(alignment: .center) {
                    ProgressView()
                }
            }
            if viewModel.detailViewState.showError {
                VStack(alignment: .center) {
                    Text(viewModel.detailViewState.errorMessage)
                    Button(NSLocalizedString("retry_label", comment: "")) {
                        viewModel.getQuoteReview(id)
                    }.padding(10)
                }.padding()
            } else {
                VStack {
                    Image(viewModel.detailViewState.quoteReviewState.imageResource)
                        .resizable()
                        .frame(width: 240.0, height: 240.0)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 7)
                    VStack(alignment: .leading) {
                        Text(viewModel.detailViewState.quoteReviewState.quote)
                            .font(.title)
                            .foregroundColor(.primary)

                        Text("William Shakespeare")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        Divider()

                        Text(NSLocalizedString("review_date_text", comment: ""))
                            .font(.subheadline)
                        Text(viewModel.detailViewState.quoteReviewState.date).font(.headline)

                        Divider()

                        Text(NSLocalizedString("rating_text", comment: ""))
                            .font(.subheadline)
                        Text(viewModel.detailViewState.quoteReviewState.rating).font(.headline)

                    }
                    .padding()

                    Spacer()
                }
            }
        }
        .padding(10)
        .onAppear(perform: {
            viewModel.getQuoteReview(id)
        }).navigationTitle(
            "\(viewModel.detailViewState.quoteReviewState.author) \(NSLocalizedString("review_text", comment: ""))"
        )
    }
}

#if DEBUG
struct MainDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MainDetailView(id: "")
    }
}
#endif
