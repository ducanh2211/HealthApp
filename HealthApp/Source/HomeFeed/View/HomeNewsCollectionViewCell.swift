//
//  HomeNewsCollectionViewCell.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 09/06/2023.
//

import UIKit
import SDWebImage

class HomeNewsCollectionViewCell: UICollectionViewCell {

    static var identifier: String {
        return String(describing: self)
    }

    private let posterImageView: UIImageView = {
        let imv = UIImageView()
        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.contentMode = .scaleAspectFill
        imv.clipsToBounds = true
        return imv
    }()

    private let mainTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.rgba(24, 25, 31, 1)
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.numberOfLines = 2
        label.text = "Jio Health khởi động chương trình Doctor Tour 2021"
        label.setContentHuggingPriority(.defaultLow - 1, for: .vertical)
        return label
    }()

    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.rgba(24, 25, 31, 1)
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.numberOfLines = 1
        label.text = "Ưu đãi hot - 28/6/2021"
        return label
    }()

    var article: Article? {
        didSet {
            configure()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layer.cornerRadius = 8
        dropShadow(color: .black, opacity: 0.3, offSet: CGSize(width: 2, height: 2), radius: 16)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        guard let article = article else { return }
        posterImageView.sd_setImage(with: URL(string: article.picture), placeholderImage: UIImage(named: "poster-image"))
        mainTitleLabel.text = article.title
        subTitleLabel.attributedText = createAttributedText(str1: "Ưu đãi hot • ", str2: article.createdAt)
    }

    private func createAttributedText(str1: String, str2: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString()
            .appendAttributedString(str1, font: .systemFont(ofSize: 13, weight: .semibold), color: UIColor.rgba(44, 134, 103, 1))
            .appendAttributedString(str2, font: .systemFont(ofSize: 13), color: UIColor.rgba(150, 155, 171, 1))
        return attributedText
    }

    private func setup() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(mainTitleLabel)
        contentView.addSubview(subTitleLabel)

        NSLayoutConstraint.activate([
            posterImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 134/258),

            mainTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            mainTitleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 12),
            mainTitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),

            subTitleLabel.leftAnchor.constraint(equalTo: mainTitleLabel.leftAnchor),
            subTitleLabel.topAnchor.constraint(equalTo: mainTitleLabel.bottomAnchor, constant: 4),
            subTitleLabel.rightAnchor.constraint(equalTo: mainTitleLabel.rightAnchor),
            subTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }

}
