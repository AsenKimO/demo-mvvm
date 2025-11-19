//
//  BirdListViewModel.swift
//  BirdWatch
//
//  Created by Asen Ou on 11/19/25.
//

import Foundation

class BirdListViewModel: ObservableObject {

    @Published var birds: [Bird] = dummyData

    // MARK: - Functions

    func loadFavorites() {
        // 1. fetch favorited bird names from UserDefaults
        let favorites = UserDefaults.standard.array(forKey: "favorites") as? [String] ?? []

        // 2. load favorites into the birds property
        // NOTE: We must redeclare the property for the ViewModel to be notified of changes
        birds = birds.map {
            var birdCopy = $0
            if favorites.contains(birdCopy.name) {
                birdCopy.isFavorited = true
            }
            return birdCopy
        }
    }

    func toggleFavorite(_ bird: Bird) {
        // NOTE: For more sensitive data, you can use Apple's iCloud Keychain through the Keychain API

        // 1. fetch favorited bird names from UserDefaults
        var favorites = UserDefaults.standard.array(forKey: "favorites") as? [String] ?? []

        // 2. Toggling favorite
        if favorites.contains(bird.name) {
            // favorited already
            favorites.removeAll { name in
                name == bird.name
            }
        } else {
            // not favorited yet
            favorites.append(bird.name)
        }

        // 3. Update UserDefaults
        UserDefaults.standard.setValue(favorites, forKey: "favorites")

        // 4. Update birds property
        // NOTE: We must redeclare the property for the ViewModel to be notified of changes
        birds = birds.map {
            if $0.name == bird.name {
                var birdCopy = $0
                birdCopy.isFavorited.toggle()
                return birdCopy
            } else {
                return $0
            }
        }
    }
}
