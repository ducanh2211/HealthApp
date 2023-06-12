//
//  UserProfileNormalTableCell.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 12/06/2023.
//

import UIKit

class UserProfileNormalTableCell: UITableViewCell {

    static var identifier: String {
        return String(describing: self)
    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.rgba(150, 155, 171, 1)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()

    private let inputTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = UIColor.rgba(24, 25, 31, 1)
        return textField
    }()

    private let expandButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 24).isActive = true
        button.heightAnchor.constraint(equalToConstant: 24).isActive = true
        button.setImage(UIImage(named: "expand"), for: .normal)
        return button
    }()

    private let dividerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.rgba(229, 229, 229, 1)
        return view
    }()

    var viewModel: UserProfileNormalCellViewModel? {
        didSet {
            updateUI()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        inputTextField.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func updateUI() {
        guard let viewModel = viewModel else { return }
        inputTextField.placeholder = viewModel.placeholderString
        titleLabel.text = viewModel.titleString
        inputTextField.text = viewModel.dataString
        switch viewModel.type {
            case .name, .lastname, .date, .gender, .phoneNumber, .email:
                inputTextField.isEnabled = true
            case .city, .district, .ward, .address, .typeBlood:
                inputTextField.isEnabled = false
        }
    }

    private func updateSelectedState() {
        titleLabel.textColor = UIColor.rgba(44, 134, 103, 1)
        dividerView.backgroundColor = UIColor.rgba(44, 134, 103, 1)
    }

    private func updateUnselectedState() {
        titleLabel.textColor = UIColor.rgba(150, 155, 171, 1)
        dividerView.backgroundColor = UIColor.rgba(229, 229, 229, 1)
    }

    private func setup() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(expandButton)
        contentView.addSubview(inputTextField)
        contentView.addSubview(dividerView)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 26),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),

            expandButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            expandButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13),

            inputTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            inputTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            inputTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),

            dividerView.leftAnchor.constraint(equalTo: inputTextField.leftAnchor),
            dividerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            dividerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
}

extension UserProfileNormalTableCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        updateSelectedState()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        updateUnselectedState()
    }
}
