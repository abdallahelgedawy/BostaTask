import UIKit

class MoviesListCollectionViewCell: UICollectionViewCell {

    static let identifier = "MovieCollectionViewCell"

    private let cardView = UIView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let favoriteButton = UIButton(type: .system)

    var onFavoriteTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCardUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        let fullPosterURL = TMDBConstants.imageBaseURL + movie.posterPath
        imageView.loadImage(from: fullPosterURL)

        let heartImage = movie.isFavorite ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: heartImage), for: .normal)
    }

    private func setupCardUI() {
        contentView.addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.layer.cornerRadius = 12
        cardView.backgroundColor = .white
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.1
        cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardView.layer.shadowRadius = 4
        cardView.layer.masksToBounds = false

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        titleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        titleLabel.numberOfLines = 2

        favoriteButton.tintColor = .systemRed
        favoriteButton.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)

        cardView.addSubview(imageView)
        cardView.addSubview(titleLabel)
        cardView.addSubview(favoriteButton)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),

            imageView.topAnchor.constraint(equalTo: cardView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.5),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -8),

            favoriteButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8),
            favoriteButton.widthAnchor.constraint(equalToConstant: 24),
            favoriteButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }

    @objc private func favoriteTapped() {
        onFavoriteTapped?()
    }
}
extension UIImageView {
    func loadImage(from urlString: String, placeholder: UIImage? = nil) {
        self.image = placeholder

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard
                let self = self,
                let data = data,
                error == nil,
                let image = UIImage(data: data)
            else { return }

            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}
