//
//  FetchMoviesUseCase.swift
//  BostaTask
//
//  Created by Abdallah Elgedawy on 15/07/2025.
//

import Foundation
final class FetchMoviesUseCase {
    private let repository: MovieRepositoryProtocol

    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }

    func execute(page: Int) async throws -> [Movie] {
        try await repository.fetchMovies(page: page)
    }
}
