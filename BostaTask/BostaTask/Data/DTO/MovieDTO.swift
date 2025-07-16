//
//  MovieDTO.swift
//  BostaTask
//
//  Created by Abdallah Elgedawy on 15/07/2025.
//

import Foundation
struct MovieDTO: Decodable {
    let id: Int
    let title: String
    let poster_path: String?
    let overview: String?
    let release_date: String?
}
