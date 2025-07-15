//
//  AppDIContainer.swift
//  BostaTask
//
//  Created by Abdallah Elgedawy on 15/07/2025.
//

import Foundation
import UIKit

final class AppDIContainer {
    func makeMovieListViewController() -> UIViewController {
        let apiService = MovieAPIService()
        let repository = MovieRepository(apiService: apiService)
        let useCase = FetchMoviesUseCase(repository: repository)
        let viewModel = MovieListViewModel(fetchMoviesUseCase: useCase)
        return MovieListViewController(viewModel: viewModel)
    }
}
