//
//  MovieDetailsViewController.swift
//  BostaTask
//
//  Created by Abdallah Elgedawy on 15/07/2025.
//

import UIKit

final class MovieDetailsViewController: UIViewController {
    private let viewModel: MovieDetailsViewModel

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    private let releaseDateLabel = UILabel()
    private let overviewTitleLabel = UILabel()
    private let overviewLabel = UILabel()

    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        setupUI()
        bindViewModel()
    }

    private func bindViewModel() {
        let posterURL = TMDBConstants.imageBaseURL + viewModel.posterURL
        posterImageView.loadImage(from: posterURL)
        titleLabel.text = viewModel.title
        releaseDateLabel.text = "Release Date: \(viewModel.releaseDate)"
        overviewLabel.text = viewModel.overview
    }

    private func setupUI() {
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 16
        posterImageView.layer.masksToBounds = true
        posterImageView.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.font = .boldSystemFont(ofSize: 26)
        titleLabel.numberOfLines = 0

        releaseDateLabel.font = .systemFont(ofSize: 14)
        releaseDateLabel.textColor = .secondaryLabel

        overviewTitleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        overviewTitleLabel.text = "Overview"

        overviewLabel.font = .systemFont(ofSize: 16)
        overviewLabel.numberOfLines = 0

        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])

        let stack = UIStackView(arrangedSubviews: [
            posterImageView, titleLabel, releaseDateLabel,
            overviewTitleLabel, overviewLabel
        ])
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stack)

        NSLayoutConstraint.activate([
            posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 1.3),

            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
        ])
    }
}
