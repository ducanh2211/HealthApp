//
//  HomeDoctorsCollectionViewCell.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 09/06/2023.
//

import UIKit

class HomeDoctorsCollectionViewCell: UICollectionViewCell {

    static var identifier: String {
        return String(describing: self)
    }

    private let avatarImageView: UIImageView = {
        let imv = UIImageView()
        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.contentMode = .scaleAspectFill
        imv.clipsToBounds = true
        return imv
    }()

    private let doctorNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = UIColor.rgba(24, 25, 31, 1)
        label.text = "Dr. Stephen"
        label.setContentHuggingPriority(.defaultLow - 1, for: .vertical)
        label.setContentCompressionResistancePriority(.defaultHigh + 1, for: .vertical)
        return label
    }()

    private let majorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.rgba(150, 155, 171, 1)
        label.text = "Pediatrics"
        return label
    }()

    private let reviewImageView: UIImageView = {
        let imv = UIImageView(image: UIImage(named: "Stroke1")!)
        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.contentMode = .scaleAspectFill
        imv.clipsToBounds = true
        return imv
    }()

    private let reviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = UIColor.rgba(24, 25, 31, 1)
        label.text = "4.8 (456)"
        return label
    }()

    var doctor: Doctor? {
        didSet {
            configure()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        clipsToBounds = true
        layer.cornerRadius = 8
        layer.borderColor = UIColor.rgba(238, 239, 244, 1).cgColor
        layer.borderWidth = 1
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        guard let doctor = doctor else { return }
        avatarImageView.sd_setImage(with: URL(string: doctor.avatar), placeholderImage: UIImage(named: "Image Doctor"))
        doctorNameLabel.text = doctor.fullName
        majorLabel.text = doctor.majorsName
        reviewLabel.attributedText = createAttributedText(str1: "\(doctor.ratioStar)", str2: " (\(doctor.numberOfStars))")
    }

    private func createAttributedText(str1: String, str2: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString()
            .appendAttributedString(str1, font: .systemFont(ofSize: 11), color: UIColor.rgba(71, 74, 87, 1))
            .appendAttributedString(str2, font: .systemFont(ofSize: 11), color: UIColor.rgba(150, 155, 171, 1))
        return attributedText
    }

    private func setup() {
        let reviewStack = UIStackView(arrangedSubviews: [reviewImageView, reviewLabel])
        reviewStack.axis = .horizontal
        reviewStack.spacing = 6
        reviewStack.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(avatarImageView)
        contentView.addSubview(doctorNameLabel)
        contentView.addSubview(majorLabel)
        contentView.addSubview(reviewStack)

        NSLayoutConstraint.activate([
            avatarImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            avatarImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),

            doctorNameLabel.leftAnchor.constraint(equalTo: avatarImageView.leftAnchor),
            doctorNameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            doctorNameLabel.rightAnchor.constraint(equalTo: avatarImageView.rightAnchor),

            majorLabel.leftAnchor.constraint(equalTo: avatarImageView.leftAnchor),
            majorLabel.topAnchor.constraint(equalTo: doctorNameLabel.bottomAnchor, constant: 4),
            majorLabel.rightAnchor.constraint(equalTo: avatarImageView.rightAnchor),

            reviewStack.leftAnchor.constraint(equalTo: avatarImageView.leftAnchor),
            reviewStack.topAnchor.constraint(equalTo: majorLabel.bottomAnchor, constant: 8),
            reviewStack.rightAnchor.constraint(equalTo: avatarImageView.rightAnchor),
            reviewStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),

            reviewImageView.widthAnchor.constraint(equalToConstant: 12),
            reviewImageView.heightAnchor.constraint(equalToConstant: 12)
        ])
    }

}
