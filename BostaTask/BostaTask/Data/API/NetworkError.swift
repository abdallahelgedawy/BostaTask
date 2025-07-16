//
//  NetworkError.swift
//  BostaTask
//
//  Created by Abdallah Elgedawy on 17/07/2025.
//

import Foundation
enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noData
    case decodingError
    case serverError(Int)
    case networkUnavailable
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data received"
        case .decodingError:
            return "Failed to decode response"
        case .serverError(let code):
            return "Server error (\(code))"
        case .networkUnavailable:
            return "Network unavailable"
        }
    }
}
