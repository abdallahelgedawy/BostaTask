//
//  MoviesListViewModel.swift
//  BostaTask
//
//  Created by Abdallah Elgedawy on 15/07/2025.
//

import Foundation

final class MovieListViewModel {
    // MARK: - Public State
    private(set) var movies: [Movie] = []
    private(set) var state: ViewState = .idle
    var onStateChange: (() -> Void)?
    var onFavoriteChanged: ((IndexPath) -> Void)?

    // MARK: - Pagination
    private var currentPage = 1
    private var isLoading = false
    private var canLoadMore = true

    // MARK: - Dependencies
    private let fetchMoviesUseCase: FetchMoviesUseCase

    // MARK: - Init
    init(fetchMoviesUseCase: FetchMoviesUseCase) {
        self.fetchMoviesUseCase = fetchMoviesUseCase
    }

    // MARK: - Public Methods
    func loadInitialMovies() {
        currentPage = 1
        movies = []
        canLoadMore = true
        loadMoreMovies()
    }

    func loadMoreMovies() {
        guard !isLoading, canLoadMore else { return }
        isLoading = true
        state = .loading
        onStateChange?()

        Task {
            do {
                let newMovies = try await fetchMoviesUseCase.execute(page: currentPage)
                self.movies.append(contentsOf: newMovies)
                self.currentPage += 1
                self.canLoadMore = !newMovies.isEmpty
                self.state = .loaded
            } catch let error as NetworkError {
                self.state = .error(error.errorDescription ?? "Unknown error")
            } catch {
                self.state = .error("Unexpected error")
            }

            self.isLoading = false
            self.onStateChange?()
        }
    }

    func toggleFavorite(for movieID: Int) {
        FavoriteMoviesStore.shared.toggleFavorite(id: movieID)

        if let index = movies.firstIndex(where: { $0.id == movieID }) {
            movies[index].isFavorite.toggle()
            let indexPath = IndexPath(item: index, section: 0)
            onFavoriteChanged?(indexPath)
        }
    }

}
