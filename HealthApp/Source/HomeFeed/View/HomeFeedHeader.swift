//
//  HomeFeedHeader.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 08/06/2023.
//

import UIKit

protocol HomeFeedHeaderDelegate: AnyObject {
    func didTapAvatarImage()
}

class HomeFeedHeader: UIView {

    private let backgroundView: UIImageView = {
        let imv = UIImageView(image: UIImage(named: "Frame45647")!)
        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.contentMode = .scaleAspectFill
        imv.clipsToBounds = true
        return imv
    }()

    private lazy var avatarImageView: UIImageView = {
        let imv = UIImageView(image: UIImage(named: "Avatar")!)
        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.contentMode = .scaleAspectFill
        imv.clipsToBounds = true
        imv.layer.borderColor = UIColor.rgba(255, 255, 255, 1).cgColor
        imv.layer.borderWidth = 1
        imv.layer.cornerRadius = 42/2
//        let tap = UITapGestureRecognizer(target: self, action: #selector())
        return imv
    }()

    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = UIColor.rgba(255, 255, 255, 1)
        label.text = "Quỳnh Ken"
        return label
    }()

    private let statusView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.rgba(17, 255, 185, 1)
        view.layer.cornerRadius = 4
        return view
    }()

    private let statusLabel: UIView = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.rgba(255, 255, 255, 0.8)
        label.text = "Đang trực tuyến"
        return label
    }()

    weak var delegate: HomeFeedHeaderDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        let statusStack = UIStackView(arrangedSubviews: [statusView, statusLabel])
        statusStack.axis = .horizontal
        statusStack.spacing = 6
        statusStack.translatesAutoresizingMaskIntoConstraints = false

        let otherStack = UIStackView(arrangedSubviews: [userNameLabel, statusStack])
        otherStack.axis = .vertical
        otherStack.spacing = 6
        otherStack.translatesAutoresizingMaskIntoConstraints = false

        addSubview(backgroundView)
        addSubview(otherStack)
        addSubview(avatarImageView)

        NSLayoutConstraint.activate([
            backgroundView.leftAnchor.constraint(equalTo: leftAnchor),
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.rightAnchor.constraint(equalTo: rightAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),

            otherStack.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            otherStack.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            statusView.widthAnchor.constraint(equalToConstant: 8),
            statusView.heightAnchor.constraint(equalToConstant: 8),

            avatarImageView.topAnchor.constraint(equalTo: otherStack.topAnchor),
            avatarImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 42),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor)
        ])
    }

}
