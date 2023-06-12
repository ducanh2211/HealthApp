//
//  InputTextField.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 08/06/2023.
//

import UIKit

protocol InputTextFieldDelegate: AnyObject {
    func textFieldDidChange(text: String)
}

class InputTextField: UITextField, UITextFieldDelegate {

    private let prefixPhoneNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = UIColor.rgba(24, 25, 31, 1)
        label.text = "+84"
        return label
    }()

    private let dividerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.rgba(238, 239, 244, 1)
        return view
    }()

    private let placeHolderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = UIColor.rgba(150, 155, 171, 1)
        label.text = "Nhập số điện thoại"
        return label
    }()

    weak var userDelegate: InputTextFieldDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange),
                                               name: UITextField.textDidChangeNotification, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func textDidChange() {
        guard let text = text else { return }
        placeHolderLabel.isHidden = !text.isEmpty
        userDelegate?.textFieldDidChange(text: text)
    }

    private func setup() {
        backgroundColor = UIColor.rgba(255, 255, 255, 1)
        layer.cornerRadius = 28
        layer.borderColor = UIColor.rgba(238, 239, 244, 1).cgColor
        layer.borderWidth = 1
        keyboardType = .numberPad
        setPaddingLeft(constant: 82)
    }

    private func setupConstraints() {
        addSubview(prefixPhoneNumberLabel)
        addSubview(dividerView)
        addSubview(placeHolderLabel)

        NSLayoutConstraint.activate([
            prefixPhoneNumberLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            prefixPhoneNumberLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            dividerView.leftAnchor.constraint(equalTo: prefixPhoneNumberLabel.rightAnchor, constant: 16),
            dividerView.widthAnchor.constraint(equalToConstant: 1),
            dividerView.heightAnchor.constraint(equalToConstant: 32),
            dividerView.centerYAnchor.constraint(equalTo: centerYAnchor),

            placeHolderLabel.leftAnchor.constraint(equalTo: dividerView.rightAnchor, constant: 16),
            placeHolderLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
