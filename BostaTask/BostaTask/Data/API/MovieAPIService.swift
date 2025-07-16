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
        guard let url = URL(string: "\(TMDBConstants.baseURL)/discover/movie?api_key=\(TMDBConstants.apiKey)&page=\(page)") else {
            throw NetworkError.invalidURL
        }

        do {
            let response = try await AF.request(url)
                .validate() // Automatically throws if status code is not 200...299
                .serializingDecodable(MoviesResponse.self)
                .value

            return response

        } catch let afError as AFError {
            if let statusCode = afError.responseCode {
                throw NetworkError.serverError(statusCode)
            }
            throw NetworkError.decodingError

        } catch {
            throw NetworkError.noData
        }
    }
}

