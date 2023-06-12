//
//  UserPorifleTableFooter.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 12/06/2023.
//

import UIKit

class UserPorifleTableFooter: UIView {

    var doneButtonTapped: (() -> Void)?

    private lazy var doneButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Xong", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        btn.layer.cornerRadius = 24
        btn.backgroundColor = UIColor.rgba(44, 134, 103, 0.3)
        btn.isEnabled = false
        btn.addTarget(self, action: #selector(didTapDoneButton), for: .touchUpInside)
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func didTapDoneButton() {
        doneButtonTapped?()
    }

    func enableDoneButton() {
        doneButton.isEnabled = true
        doneButton.backgroundColor = UIColor.rgba(44, 134, 103, 1)
    }

    private func setup() {
        addSubview(doneButton)
        NSLayoutConstraint.activate([
            doneButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 48),
            doneButton.heightAnchor.constraint(equalToConstant: 48),
            doneButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            doneButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20)
        ])
    }
}
