//
//  BirdListView.swift
//  BirdWatch
//
//  Created by Vin Bui on 11/13/23.
//

import SwiftUI

struct BirdListView: View {

    @StateObject var viewModel = BirdListViewModel()

    @AppStorage("isDarkModeEnabled") private var isDarkModeEnabled: Bool = false

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
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            isDarkModeEnabled.toggle()
                        } label: {
                            HStack {
                                Image(systemName: isDarkModeEnabled ? "moon.fill" : "sun.max.fill")
                                Text(isDarkModeEnabled ? "Dark Mode" : "Light Mode")
                            }
                            .padding(10)
                        }
                    }
                }
        }
        .environment(\.colorScheme, isDarkModeEnabled ? .dark : .light)
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
