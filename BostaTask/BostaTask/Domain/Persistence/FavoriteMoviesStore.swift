//
//  FavoriteMoviesStore.swift
//  BostaTask
//
//  Created by Abdallah Elgedawy on 15/07/2025.
//

import Foundation

final class FavoriteMoviesStore {
    private let key = "favoriteMovieIDs"

    static let shared = FavoriteMoviesStore()

    private init() {}

    func isFavorite(id: Int) -> Bool {
        return getFavorites().contains(id)
    }

    func toggleFavorite(id: Int) {
        var favorites = getFavorites()
        if favorites.contains(id) {
            favorites.remove(id)
        } else {
            favorites.insert(id)
        }
        saveFavorites(favorites)
    }

    private func getFavorites() -> Set<Int> {
        let ids = UserDefaults.standard.array(forKey: key) as? [Int] ?? []
        return Set(ids)
    }

    private func saveFavorites(_ favorites: Set<Int>) {
        UserDefaults.standard.set(Array(favorites), forKey: key)
    }
}
