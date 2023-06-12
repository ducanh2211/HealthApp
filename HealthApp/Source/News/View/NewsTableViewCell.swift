//
//  NewsTableViewCell.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 09/06/2023.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    static var idetifier: String {
        return String(describing: self)
    }

    private let posterImageView: UIImageView = {
        let imv = UIImageView()
        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.contentMode = .scaleAspectFill
        imv.clipsToBounds = true
        imv.backgroundColor = .systemPink
        imv.layer.cornerRadius = 8
        return imv
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.rgba(18, 18, 18, 1)
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
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

    private lazy var bookmarkButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "bookmark"), for: .normal)
        btn.addTarget(self, action: #selector(didTapBookmarkButton), for: .touchUpInside)
        btn.contentVerticalAlignment = .fill
        btn.contentHorizontalAlignment = .fill
        btn.tintColor = UIColor.rgba(150, 155, 171, 1)
        return btn
    }()

    var article: Article? {
        didSet {
            configure()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func didTapBookmarkButton() {

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
        contentView.addSubview(bookmarkButton)

        NSLayoutConstraint.activate([
            posterImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            posterImageView.widthAnchor.constraint(equalToConstant: 150),
            posterImageView.heightAnchor.constraint(equalToConstant: 78),

            titleLabel.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: 12),
            titleLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),

            dateLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            dateLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor),

            bookmarkButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            bookmarkButton.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor),
            bookmarkButton.widthAnchor.constraint(equalToConstant: 11),
            bookmarkButton.heightAnchor.constraint(equalToConstant: 14)
        ])
    }
}
