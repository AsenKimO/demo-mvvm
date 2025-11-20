//
//  BirdListView.swift
//  BirdWatch
//
//  Created by Vin Bui on 11/13/23.
//

import SwiftUI

struct BirdListView: View {

    @StateObject var viewModel = BirdListViewModel()

    var body: some View {
        NavigationStack {
            mainView
                .navigationTitle("Bird List")
                .overlay {
                    switch viewModel.loadingState {
                    case .loaded:
                        // render nothing
                        EmptyView()
                    case .loading:
                        loadingView
                    case .error(let error):
                        errorView(description: error.localizedDescription)
                    }
                }
        }
        .onAppear {
            viewModel.fetchBirds()
        }
    }

    private var mainView: some View {
        List(viewModel.birds, id: \.self) { bird in
            birdInfoRow(bird)
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.toggleFavorite(bird)
                }
        }
        .refreshable {
            if case .loading = viewModel.loadingState {
                return
            }
            viewModel.fetchBirds()
        }
    }

    private var loadingView: some View {
        ProgressView {
            Text("Loading Birds...")
        }
    }

    private func errorView(description: String) -> some View {
        VStack {
            Text("ERROR:")
            Text(description)
        }
    }

    private func birdInfoRow(_ bird: Bird) -> some View {
        HStack {
            Text(String(bird.count))
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.trailing, 30)

            VStack(alignment: .leading) {
                Text(bird.name)
                    .fontWeight(.bold)

                Text(bird.location)
                    .fontWeight(.medium)
                    .italic()
            }
            .font(.title2)

            Spacer()

            Image(bird.image)
                .resizable()
                .frame(width: 100, height: 100)

            VStack {
                Image(systemName: bird.isFavorited ? "star.fill" : "star")
                Spacer()
            }
        }
    }

}

#Preview {
    BirdListView()
}
