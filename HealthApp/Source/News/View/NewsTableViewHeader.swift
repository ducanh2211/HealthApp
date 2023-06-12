//
//  NewsTableViewHeader.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 09/06/2023.
//

import UIKit

protocol NewsTableViewHeaderDelegate: AnyObject {
    func didTapOnHeader()
}

class NewsTableViewHeader: UITableViewHeaderFooterView {

    static var idetifier: String {
        return String(describing: self)
    }

    private let posterImageView: UIImageView = {
        let imv = UIImageView()
        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.contentMode = .scaleAspectFill
        imv.clipsToBounds = true
        return imv
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.rgba(18, 18, 18, 1)
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 3
        label.text = "Đổi Jio Points - Rinh quà sức khỏe"
        label.setContentHuggingPriority(.defaultLow - 1, for: .vertical)
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.rgba(125, 132, 152, 1)
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 1
        label.text = "28/6/2021"
        return label
    }()

    var article: Article? {
        didSet {
            configure()
        }
    }
    weak var delegate: NewsTableViewHeaderDelegate?

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        guard let article = article else { return }
        posterImageView.sd_setImage(with: URL(string: article.picture), placeholderImage: UIImage(named: "Image"))
        titleLabel.text = article.title
        dateLabel.text = article.createdAt
    }

    private func setup() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)

        NSLayoutConstraint.activate([
            posterImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 200/375),

            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 12),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),

            dateLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            dateLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
}
