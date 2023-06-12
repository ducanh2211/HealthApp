//
//  NewsController.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 09/06/2023.
//

import UIKit

class NewsController: UIViewController {

    private var navBar: CustomNavigationBar!
    private var tableView: UITableView!
    private let tableHeader = NewsTableViewHeader()
    private let viewModel = NewsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }

    private func bindViewModel() {
        viewModel.getDataSuccess = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.getArticleList()
    }

    private func setupView() {
        view.backgroundColor = .white
        setupNavBar()
        setupTableView()
        setupConstraints()
    }

    private func setupNavBar() {
        let settings = NavigationBarSetting(backgroundColor: UIColor.rgba(255, 255, 255, 1),
                                            title: "Tin tức",
                                            shouldShowRightBarButton: false,
                                            backButtonAction: { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        })
        navBar = CustomNavigationBar(settings: settings)
    }

    private func setupTableView() {
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = UIColor.rgba(255, 255, 255, 1)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 180
        tableView.estimatedSectionHeaderHeight = 260
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.register(NewsTableViewCell.self,
                           forCellReuseIdentifier: NewsTableViewCell.idetifier)
    }

    private func setupConstraints() {
        navBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(navBar)
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            navBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBar.rightAnchor.constraint(equalTo: view.rightAnchor),

            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.topAnchor.constraint(equalTo: navBar.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension NewsController: NewsTableViewHeaderDelegate {
    func didTapOnHeader() {

    }
}

extension NewsController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel.articleList.count
        return count == 0 ? 0 : count - 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.idetifier, for: indexPath) as! NewsTableViewCell
        cell.article = viewModel.articleList[indexPath.row + 1]
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableHeader.delegate = self
        let count = viewModel.articleList.count
        if count != 0 {
            tableHeader.article = viewModel.articleList[0]
        }
        return tableHeader
    }
}
