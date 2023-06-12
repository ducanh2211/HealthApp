//
//  AuthenticationController.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 08/06/2023.
//

import UIKit

class AuthenticationController: UIViewController {

    private lazy var navBar: CustomNavigationBar = {
        let settings = NavigationBarSetting(backgroundColor: UIColor.clear,
                                            title: "Xác minh số điện thoại",
                                            shouldShowRightBarButton: false,
                                            backButtonAction: { [weak self] in
            self?.didTapBackButton()
        })
        let view = CustomNavigationBar(settings: settings)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let instructionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private let otpStackView: OTPStackView = {
        let stack = OTPStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor.rgba(252, 36, 53, 1)
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()

    private lazy var counterButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.isEnabled = false
        btn.backgroundColor = UIColor.rgba(44, 134, 103, 0.3)
        btn.layer.cornerRadius = 24
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        btn.setTitleColor(UIColor.white, for: .normal)
//        btn.addTarget(self, action: #selector(didTapContinueButton), for: .touchUpInside)
        return btn
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

    var phoneNumberString: String = "" {
        didSet {
            let attributedText = NSMutableAttributedString()
                .appendAttributedString("Vui lòng nhập mã gồm 6 chữ số đã được gửi đến bạn vào số điện thoại +", font: UIFont.systemFont(ofSize: 14), color: UIColor.rgba(54, 61, 78, 1))
                .appendAttributedString(phoneNumberString, font: UIFont.systemFont(ofSize: 14, weight: .semibold), color: UIColor.rgba(54, 61, 78, 1))
            instructionLabel.attributedText = attributedText
        }
    }

    var continueButtonBottomConstraint: NSLayoutConstraint!
    let validateOTP: String = "111111"

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        otpStackView.delegate = self
        addNotification()
    }

    deinit {
        removeNotification()
    }

    // MARK: - Functions

    @objc private func didTapContinueButton() {
        let otpString = otpStackView.getOTP()
        if otpString == validateOTP {
            let vc = HomeFeedController()
            navigationController?.pushViewController(vc, animated: true)
        } else {

        }
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        let keyboardSize: CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
        let duration: TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0

        continueButtonBottomConstraint.constant = -keyboardSize.height + view.safeAreaInsets.bottom - 16
        UIView.animate(withDuration: duration, delay: 0) {
            self.view.layoutIfNeeded()
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        let duration: TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0

        continueButtonBottomConstraint.constant = -16
        UIView.animate(withDuration: duration, delay: 0) {
            self.view.layoutIfNeeded()
        }
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
    
    private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }

    private func addNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func removeNotification() {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Setup

    private func setupView() {
        view.backgroundColor = UIColor.rgba(243, 245, 251, 1)
        setupConstraints()
    }

    private func setupConstraints() {
        view.addSubview(navBar)
        view.addSubview(instructionLabel)
        view.addSubview(otpStackView)
        view.addSubview(errorLabel)
        view.addSubview(continueButton)

        continueButtonBottomConstraint = continueButton.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)

        NSLayoutConstraint.activate([
            navBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBar.rightAnchor.constraint(equalTo: view.rightAnchor),

            instructionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            instructionLabel.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 20),
            instructionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),

            otpStackView.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 20),
            otpStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            otpStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            otpStackView.heightAnchor.constraint(equalToConstant: 42),

            continueButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            continueButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            continueButton.heightAnchor.constraint(equalToConstant: 48),
            continueButtonBottomConstraint,
        ])
    }

}

extension AuthenticationController: OTPDelegate {
    func didChangeValidity(isValid: Bool) {
        if isValid {
            enableContinueButton()
        } else {
            disableContinueButton()
        }
    }
}
