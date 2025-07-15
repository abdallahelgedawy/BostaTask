//
//  MovieMapper.swift
//  BostaTask
//
//  Created by Abdallah Elgedawy on 15/07/2025.
//

import Foundation
extension MovieDTO {
    func toDomain() -> Movie {
        return Movie(
            id: id,
            title: title,
            posterPath: poster_path ?? ""
        )
    }
}
