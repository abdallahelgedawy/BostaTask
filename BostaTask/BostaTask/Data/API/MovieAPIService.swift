//
//  MovieAPIService.swift
//  BostaTask
//
//  Created by Abdallah Elgedawy on 15/07/2025.
//

import Foundation
import Alamofire
protocol MovieAPIServiceProtocol {
    func fetchMovies(page: Int) async throws -> MoviesResponse
}

final class MovieAPIService: MovieAPIServiceProtocol {
    func fetchMovies(page: Int) async throws -> MoviesResponse {
        let url = "\(TMDBConstants.baseURL)/discover/movie?api_key=\(TMDBConstants.apiKey)&page=\(page)"
        let response = try await AF.request(url).serializingDecodable(MoviesResponse.self).value
        return response
    }
}
