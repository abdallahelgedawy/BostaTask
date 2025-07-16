//
//  MovieRepository.swift
//  BostaTask
//
//  Created by Abdallah Elgedawy on 15/07/2025.
//

import Foundation
final class MovieRepository: MovieRepositoryProtocol {
    private let apiService: MovieAPIServiceProtocol

    init(apiService: MovieAPIServiceProtocol) {
        self.apiService = apiService
    }

    func fetchMovies(page: Int) async throws -> [Movie] {
        let response = try await apiService.fetchMovies(page: page)
        return response.results.map { $0.toDomain() }
    }
}
