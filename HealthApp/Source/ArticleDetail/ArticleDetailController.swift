//
//  ArticleDetailController.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 09/06/2023.
//

import UIKit
import WebKit

class ArticleDetailController: UIViewController, WKNavigationDelegate {

    private var navBar: CustomNavigationBar!
    private var loadingIndicator: UIActivityIndicatorView!
    private let webView = WKWebView()
    private let link: String

    init(link: String) {
        self.link = link
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        webView.navigationDelegate = self
        setupNavBar()
        setupLoadingIndicator()
        setupConstraint()
        loadWebView()
    }

    private func loadWebView() {
        guard let url = URL(string: link) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingIndicator.stopAnimating()
    }
    
    private func setupNavBar() {
        let settings = NavigationBarSetting(backgroundColor: UIColor.rgba(255, 255, 255, 1),
                                            title: "Chi tiết tin tức",
                                            shouldShowRightBarButton: false,
                                            backButtonAction: { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        })
        navBar = CustomNavigationBar(settings: settings)
    }

    private func setupLoadingIndicator() {
        loadingIndicator = UIActivityIndicatorView()
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.startAnimating()
    }

    private func setupConstraint() {
        navBar.translatesAutoresizingMaskIntoConstraints = false
        webView.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(navBar)
        view.addSubview(webView)
        view.addSubview(loadingIndicator)

        NSLayoutConstraint.activate([
            navBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBar.rightAnchor.constraint(equalTo: view.rightAnchor),

            webView.leftAnchor.constraint(equalTo: view.leftAnchor),
            webView.topAnchor.constraint(equalTo: navBar.bottomAnchor),
            webView.rightAnchor.constraint(equalTo: view.rightAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
