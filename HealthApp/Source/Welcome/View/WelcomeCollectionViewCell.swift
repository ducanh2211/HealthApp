//
//  WelcomeCollectionViewCell.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 06/06/2023.
//

import UIKit

class WelcomeCollectionViewCell: UICollectionViewCell {

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
        label.textColor = UIColor.rgba(36, 42, 97, 1)
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Bác sĩ sẵn lòng chăm sóc khi bạn cần"
        return label
    }()

    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.rgba(54, 61, 78, 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Chọn chuyên khoa, bác sĩ phù hợp và được thăm khám trong không gian thoải mái tại nhà"
        return label
    }()

    var posterImageString: String! {
        didSet {
            posterImageView.image = UIImage(named: posterImageString)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(mainTitleLabel)
        contentView.addSubview(subTitleLabel)

        NSLayoutConstraint.activate([
            posterImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor),

            mainTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 38),
            mainTitleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 40),
            mainTitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -38),

            subTitleLabel.leftAnchor.constraint(equalTo: mainTitleLabel.leftAnchor),
            subTitleLabel.topAnchor.constraint(equalTo: mainTitleLabel.bottomAnchor, constant: 8),
            subTitleLabel.rightAnchor.constraint(equalTo: mainTitleLabel.rightAnchor)
        ])
    }
}
