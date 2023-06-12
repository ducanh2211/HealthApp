//
//  LoginController.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 08/06/2023.
//

import UIKit

class LoginController: UIViewController {

    // MARK: - UI components

    private let headerView: UIImageView = {
        let imv = UIImageView(image: UIImage(named: "BG")!)
        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.contentMode = .scaleAspectFill
        imv.clipsToBounds = true
        return imv
    }()

    private lazy var backButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor.rgba(0, 61, 115, 0.3)
        btn.layer.cornerRadius = 32/2
        btn.setImage(UIImage(named: "back-arrow"), for: .normal)
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        return btn
    }()

    private let languageButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor.rgba(0, 61, 115, 0.3)
        btn.layer.cornerRadius = 15
        btn.setTitle("EN / VI", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        return btn
    }()

    private let inputTextField: InputTextField = {
        let textField = InputTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var continueButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.isEnabled = false
        btn.backgroundColor = UIColor.rgba(44, 134, 103, 0.3)
        btn.layer.cornerRadius = 24
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        btn.setTitle("Tiếp tục", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.addTarget(self, action: #selector(didTapContinueButton), for: .touchUpInside)
        return btn
    }()

    private let hotlineButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor.rgba(14, 173, 105, 0.05)
        btn.layer.cornerRadius = 24
        btn.tintColor = UIColor.rgba(44, 134, 103, 1)
        let attributedText = NSMutableAttributedString()
            .appendAttributedString("Hotline", font: .systemFont(ofSize: 17), color: .rgba(24, 25, 31, 1))
            .appendAttributedString(" 1900 6036 893", font: .systemFont(ofSize: 17, weight: .semibold), color: .rgba(44, 134, 103, 1))
        btn.setAttributedTitle(attributedText, for: .normal)
        btn.setImage(UIImage(named: "Phone"), for: .normal)
        btn.titleEdgeInsets.left = 20
        return btn
    }()

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        inputTextField.delegate = self
        inputTextField.addTarget(self, action: #selector(inputTextFieldTextDidChange), for: .editingChanged)
    }

    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func didTapContinueButton() {
        guard let phoneString = inputTextField.text else { return }
        let vc = AuthenticationController()
        vc.phoneNumberString = phoneString
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc private func inputTextFieldTextDidChange() {
        guard let text = inputTextField.text else { return }
        guard let firstCharacter = text.first else { return }
        let shouldEnable = (firstCharacter == "0" && text.count == 10) ||
        (firstCharacter != "0" && text.count == 9)
        shouldEnable ? enableContinueButton() : disableContinueButton()
    }

    // MARK: - Helper

    private func enableContinueButton() {
        continueButton.isEnabled = true
        continueButton.backgroundColor = UIColor.rgba(44, 134, 103, 1)
    }

    private func disableContinueButton() {
        continueButton.isEnabled = false
        continueButton.backgroundColor = UIColor.rgba(44, 134, 103, 0.3)
    }

    private func highlightInputTextField() {
        UIView.animate(withDuration: 0.25, delay: 0) {
            self.inputTextField.layer.borderColor = UIColor.rgba(44, 134, 103, 1).cgColor
        }
    }

    private func deactiveInputTextField() {
        UIView.animate(withDuration: 0.25, delay: 0) {
            self.inputTextField.layer.borderColor = UIColor.rgba(238, 239, 244, 1).cgColor
        }
    }

    // MARK: - Setup

    private func setupView() {
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        hideKeyBoardWhenTapped()
        setupConstraint()
        inputTextField.dropShadow(opacity: 0.3, offSet: CGSize(width: 0, height: 3), radius: 5)
    }

    private func setupConstraint() {
        view.addSubview(headerView)
        view.addSubview(backButton)
        view.addSubview(languageButton)
        view.addSubview(inputTextField)
        view.addSubview(continueButton)
        view.addSubview(hotlineButton)

        NSLayoutConstraint.activate([
            headerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            headerView.heightAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 188/375),

            backButton.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 16),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4),
            backButton.widthAnchor.constraint(equalToConstant: 32),
            backButton.heightAnchor.constraint(equalTo: backButton.widthAnchor),

            languageButton.topAnchor.constraint(equalTo: backButton.topAnchor),
            languageButton.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -16),
            languageButton.widthAnchor.constraint(equalToConstant: 69),
            languageButton.heightAnchor.constraint(equalToConstant: 28),

            inputTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            inputTextField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 56),
            inputTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            inputTextField.heightAnchor.constraint(equalToConstant: 56),

            continueButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            continueButton.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: 20),
            continueButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            continueButton.heightAnchor.constraint(equalToConstant: 48),

            hotlineButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            hotlineButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            hotlineButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            hotlineButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
}

extension LoginController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        highlightInputTextField()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        deactiveInputTextField()
    }
}
