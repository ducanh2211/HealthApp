//
//  PromotionDetailsController.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 09/06/2023.
//

import UIKit

class PromotionController: UIViewController {

    private var navBar: CustomNavigationBar!
    private var tableView: UITableView!
    private var tableHeader = PromotionHeaderView()
    private let viewModel = PromotionViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }

    private func bindViewModel() {
        viewModel.getDataSuccess = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.getPromotionList()
    }

    private func setupView() {
        view.backgroundColor = .white
        setupNavBar()
        setupTableView()
        setupConstraints()
    }

    private func setupNavBar() {
        let settings = NavigationBarSetting(backgroundColor: UIColor.rgba(255, 255, 255, 1),
                                            title: "Danh sách khuyến mãi",
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
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = 64
        tableView.register(PromotionTableViewCell.self,
                           forCellReuseIdentifier: PromotionTableViewCell.identifier)
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

extension PromotionController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.promotionList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PromotionTableViewCell.identifier, for: indexPath) as! PromotionTableViewCell
        cell.promotion = viewModel.promotionList[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableHeader
    }
}
