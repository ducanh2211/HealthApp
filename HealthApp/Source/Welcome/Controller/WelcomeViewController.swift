//
//  WelcomeViewController.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 06/06/2023.
//

import UIKit

class WelcomeViewController: UIViewController {

    private var collectionView: UICollectionView!

    private let pageControl: UIPageControl = {
        let page = UIPageControl()
        page.translatesAutoresizingMaskIntoConstraints = false
        page.numberOfPages = 3
        page.currentPage = 0
        page.pageIndicatorTintColor = UIColor.rgba(44, 134, 103, 0.3)
        page.currentPageIndicatorTintColor = UIColor.rgba(44, 134, 103, 1)
        return page
    }()

    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.rgba(255, 255, 255, 1)
        return view
    }()

    private let backgroundView: UIImageView = {
        let imv = UIImageView(image: UIImage(named: "Rectangle 414")!)
        imv.contentMode = .scaleAspectFill
        imv.clipsToBounds = true
        return imv
    }()

    private lazy var loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Đăng nhập", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        btn.backgroundColor = UIColor.rgba(44, 134, 103, 1)
        btn.layer.cornerRadius = 48/2
        btn.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        return btn
    }()

    private lazy var signUpButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Tạo tài khoản", for: .normal)
        btn.setTitleColor(UIColor.rgba(36, 42, 97, 1), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        btn.layer.cornerRadius = 48/2
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.rgba(36, 42, 97, 1).cgColor
        btn.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        return btn
    }()

    private var dataSource: [String] = [
        "Healthtracker-1", "Healthtracker-2", "Healthtracker-3"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.rgba(243, 245, 251, 1)
        navigationController?.isNavigationBarHidden = true
        setupCollectionView()
        setupConstraints()
    }

    @objc private func didTapLoginButton() {
        let vc = LoginController()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc private func didTapSignUpButton() {
        let vc = LoginController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.backgroundView = backgroundView
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(WelcomeCollectionViewCell.self, forCellWithReuseIdentifier: WelcomeCollectionViewCell.identifier)
    }

    private func setupConstraints() {
        containerView.addSubview(loginButton)
        containerView.addSubview(signUpButton)
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(containerView)

        collectionView.translatesAutoresizingMaskIntoConstraints = false

        let pageControlBottomConstraint = pageControl.bottomAnchor.constraint(greaterThanOrEqualTo: containerView.topAnchor, constant: -10)
        pageControlBottomConstraint.priority = UILayoutPriority(999)

        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.4),

            pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 26),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            containerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            loginButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16),
            loginButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            loginButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.4),
            loginButton.heightAnchor.constraint(equalToConstant: 48),

            signUpButton.topAnchor.constraint(equalTo: loginButton.topAnchor),
            signUpButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16),
            signUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            signUpButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.48),
            signUpButton.heightAnchor.constraint(equalTo: loginButton.heightAnchor)
        ])
    }
}

extension WelcomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WelcomeCollectionViewCell.identifier, for: indexPath) as! WelcomeCollectionViewCell
        cell.posterImageString = dataSource[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.x
        let currentIndex = Int(round(currentOffset/scrollView.frame.width))
        pageControl.currentPage = currentIndex
    }
}
