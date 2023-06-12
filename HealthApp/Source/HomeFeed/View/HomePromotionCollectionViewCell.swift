//
//  HomePromotionCollectionViewCell.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 09/06/2023.
//

import UIKit

class HomePromotionCollectionViewCell: UICollectionViewCell {

    static var identifier: String {
        return String(describing: self)
    }

    private let posterImageView: UIImageView = {
        let imv = UIImageView()
        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.contentMode = .scaleAspectFill
        imv.clipsToBounds = true
        imv.image = UIImage(named: "poster-image")
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

    var promotion: Promotion? {
        didSet {
            configure()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        clipsToBounds = true
        layer.cornerRadius = 8
        contentView.dropShadow(opacity: 0.3, offSet: CGSize(width: 0, height: 3), radius: 15)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        guard let promotion = promotion else { return }
        posterImageView.sd_setImage(with: URL(string: promotion.picture))
        mainTitleLabel.text = promotion.name
        subTitleLabel.attributedText = createAttributedText(str1: "Ưu đãi hot • ", str2: promotion.createdAt)
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
