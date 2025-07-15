//
//  MoviesListViewController.swift
//  BostaTask
//
//  Created by Abdallah Elgedawy on 15/07/2025.
//

import Foundation
import UIKit

final class MovieListViewController: UIViewController {
    private var collectionView: UICollectionView!
    private let viewModel: MovieListViewModel
    private let loadingIndicator = UIActivityIndicatorView(style: .large)

    init(viewModel: MovieListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movies"
        view.backgroundColor = .white
        setupCollectionView()
        bindViewModel()
        viewModel.loadInitialMovies()
        setupLoadingIndicator()

    }
    
    private func setupLoadingIndicator() {
        view.addSubview(loadingIndicator)
        loadingIndicator.color = .darkGray
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.hidesWhenStopped = true

        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    
    private func bindViewModel() {
        viewModel.onStateChange = { [weak self] in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch self.viewModel.state {
                case .loading:
                    self.loadingIndicator.startAnimating()
                case .loaded, .idle:
                    self.loadingIndicator.stopAnimating()
                case .error(let message):
                    self.loadingIndicator.stopAnimating()
                    self.showErrorAlert(message: message)
                }
                self.collectionView.reloadData()
            }
        }

        viewModel.onFavoriteChanged = { [weak self] indexPath in
            DispatchQueue.main.async {
                self?.collectionView.reloadItems(at: [indexPath])
            }
        }
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Oops!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }


    
        private func setupCollectionView() {
            let layout = UICollectionViewFlowLayout()
            let spacing: CGFloat = 8
            let itemsPerRow: CGFloat = 2
            let itemWidth = (view.bounds.width - (itemsPerRow + 1) * spacing) / itemsPerRow
            layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.8)
            layout.minimumInteritemSpacing = spacing
            layout.minimumLineSpacing = spacing
            collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(MoviesListCollectionViewCell.self, forCellWithReuseIdentifier: "MoviesListCollectionViewCell")
            collectionView.contentInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
            view.addSubview(collectionView)
        }
    }
    
    // MARK: - UICollectionViewDelegate, DataSource
    extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            viewModel.movies.count
        }
    
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesListCollectionViewCell", for: indexPath) as? MoviesListCollectionViewCell else {
                return UICollectionViewCell()
            }
    
            let movie = viewModel.movies[indexPath.row]
            cell.configure(with: movie)
            cell.onFavoriteTapped = { [weak self] in
                self?.viewModel.toggleFavorite(for: movie.id)
            }
    
            return cell
        }
    
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
    
            if offsetY > contentHeight - scrollView.frame.height * 1.5 {
                viewModel.loadMoreMovies()
            }
        }
    
}
