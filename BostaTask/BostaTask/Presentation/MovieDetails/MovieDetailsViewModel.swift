//
//  MovieDetailsViewModel.swift
//  BostaTask
//
//  Created by Abdallah Elgedawy on 15/07/2025.
//

import Foundation
final class MovieDetailsViewModel {
    let movie: Movie

    init(movie: Movie) {
        self.movie = movie
    }

    var title: String { movie.title }
    var overview: String { movie.overview }
    var releaseDate: String { movie.release_date }
    var posterURL: String { movie.posterPath }
}
