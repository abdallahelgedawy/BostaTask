//
//  MovieRepositoryProtocol.swift
//  BostaTask
//
//  Created by Abdallah Elgedawy on 15/07/2025.
//

import Foundation
protocol MovieRepositoryProtocol {
    func fetchMovies(page: Int) async throws -> [Movie]
}
