//
//  DoctorTableViewCell.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 09/06/2023.
//

import UIKit

class DoctorTableViewCell: UITableViewCell {

    static var identifier: String {
        return String(describing: self)
    }

    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.rgba(238, 239, 244, 1).cgColor
        view.layer.borderWidth = 1
        return view
    }()

    private let avatarImageView: UIImageView = {
        let imv = UIImageView()
        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.contentMode = .scaleAspectFill
        imv.clipsToBounds = true
        imv.backgroundColor = .systemBlue
        imv.layer.cornerRadius = 6
        return imv
    }()

    private let doctorNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.numberOfLines = 0
        label.textColor = UIColor.rgba(24, 25, 31, 1)
        label.text = "BS. Đoàn Văn Quang Quang Quang Quang "
        label.setContentHuggingPriority(.defaultLow - 1, for: .vertical)
        label.setContentCompressionResistancePriority(.defaultHigh + 1, for: .vertical)
        return label
    }()

    private let majorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textColor = UIColor.rgba(150, 155, 171, 1)
        label.text = "Chuyên ngành: Phẫu thuật chỉnh hình đẹp trai"
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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        guard let doctor = doctor else { return }
        avatarImageView.sd_setImage(with: URL(string: doctor.avatar), placeholderImage: UIImage(named: "Image Doctor"))
        doctorNameLabel.text = doctor.fullName
        majorLabel.text = doctor.majorsName
        reviewLabel.attributedText = createAttributedText(str1: "\(doctor.ratioStar)",
                                                          str2: " (\(doctor.numberOfStars) Đánh giá")
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

        let labelStack = UIStackView(arrangedSubviews: [doctorNameLabel, majorLabel, reviewStack])
        labelStack.axis = .vertical
        labelStack.spacing = 6
        labelStack.translatesAutoresizingMaskIntoConstraints = false

        let finalStack = UIStackView(arrangedSubviews: [avatarImageView, labelStack])
        finalStack.axis = .horizontal
        finalStack.spacing = 15
        finalStack.alignment = .top
        finalStack.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(containerView)
        containerView.addSubview(finalStack)

        NSLayoutConstraint.activate([
            containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            finalStack.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 12),
            finalStack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            finalStack.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -12),
            finalStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),

            avatarImageView.widthAnchor.constraint(equalToConstant: 80),
            avatarImageView.heightAnchor.constraint(equalToConstant: 80),

            reviewImageView.widthAnchor.constraint(equalToConstant: 13),
            reviewImageView.heightAnchor.constraint(equalToConstant: 13)
        ])
    }
}
