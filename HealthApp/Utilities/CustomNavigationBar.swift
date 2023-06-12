//
//  CustomNavigationBar.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 08/06/2023.
//

import UIKit

struct NavigationBarSetting {
    var backgroundColor: UIColor
    var title: String
    var shouldShowRightBarButton: Bool
    var backButtonAction: (() -> Void)? = nil
    var rightBarButtonAction: (() -> Void)? = nil
}

class CustomNavigationBar: UIView {

    var backButton: UIButton!
    var titleLalbel: UILabel!
    var rightBarButton: UIButton!
    var settings: NavigationBarSetting

    init(settings: NavigationBarSetting) {
        self.settings = settings
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func didTapBackButton() {
        settings.backButtonAction?()
    }

    @objc private func didTapRightBarButton() {
        if settings.shouldShowRightBarButton {
            settings.rightBarButtonAction?()
        }
    }

    private func setup() {
        backgroundColor = settings.backgroundColor
        setupBackButton()
        setupTitleLabel()
        setupRightBarButton()
        setupConstraints()
    }

    private func setupBackButton() {
        backButton = UIButton(type: .system)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.backgroundColor = UIColor.rgba(255, 255, 255, 1)
        backButton.layer.borderColor = UIColor.rgba(238, 239, 244, 1).cgColor
        backButton.layer.borderWidth = 1
        backButton.layer.cornerRadius = 32/2
        backButton.setImage(UIImage(named: "back-arrow"), for: .normal)
        backButton.tintColor = UIColor.rgba(36, 42, 97, 1)
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
    }

    private func setupTitleLabel() {
        titleLalbel = UILabel()
        titleLalbel.translatesAutoresizingMaskIntoConstraints = false
        titleLalbel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLalbel.text = settings.title
        titleLalbel.textColor = UIColor.rgba(36, 42, 97, 1)
        titleLalbel.textAlignment = .center
        titleLalbel.numberOfLines = 1
    }

    private func setupRightBarButton() {
        if settings.shouldShowRightBarButton {
            rightBarButton = UIButton(type: .system)
            rightBarButton.translatesAutoresizingMaskIntoConstraints = false
            rightBarButton.backgroundColor = UIColor.rgba(255, 255, 255, 1)
            rightBarButton.layer.borderColor = UIColor.rgba(238, 239, 244, 1).cgColor
            rightBarButton.layer.borderWidth = 1
            rightBarButton.layer.cornerRadius = 32/2
            rightBarButton.setImage(UIImage(named: "save"), for: .normal)
            rightBarButton.tintColor = UIColor.rgba(36, 42, 97, 1)
            rightBarButton.addTarget(self, action: #selector(didTapRightBarButton), for: .touchUpInside)
        }
    }

    private func setupConstraints() {
        addSubview(backButton)
        addSubview(titleLalbel)
        NSLayoutConstraint.activate([
            backButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            backButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
            backButton.widthAnchor.constraint(equalToConstant: 32),
            backButton.heightAnchor.constraint(equalTo: backButton.widthAnchor),

            titleLalbel.leftAnchor.constraint(equalTo: backButton.rightAnchor, constant: 10),
            titleLalbel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLalbel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        if settings.shouldShowRightBarButton {
            addSubview(rightBarButton)
            NSLayoutConstraint.activate([
                rightBarButton.leftAnchor.constraint(equalTo: titleLalbel.rightAnchor, constant: 10),
                rightBarButton.topAnchor.constraint(equalTo: topAnchor, constant: 6),
                rightBarButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
                rightBarButton.widthAnchor.constraint(equalTo: backButton.widthAnchor),
                rightBarButton.heightAnchor.constraint(equalTo: backButton.heightAnchor),
            ])
        } else {
            NSLayoutConstraint.activate([
                titleLalbel.rightAnchor.constraint(equalTo: rightAnchor, constant: -58)
            ])
        }

    }
}
