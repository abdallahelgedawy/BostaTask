//
//  Movie.swift
//  BostaTask
//
//  Created by Abdallah Elgedawy on 15/07/2025.
//

import Foundation
struct Movie {
    let id: Int
    let title: String
    let posterPath: String
    var isFavorite: Bool
    var overview: String
    var release_date: String
    
    init(id: Int, title: String, posterPath: String,overview:String,release_date:String) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.isFavorite = FavoriteMoviesStore.shared.isFavorite(id: id)
        self.overview = overview
        self.release_date = release_date
    }
}


