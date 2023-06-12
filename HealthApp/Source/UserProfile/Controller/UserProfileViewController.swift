//
//  UserProfileViewController.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 12/06/2023.
//

import UIKit

class UserProfileViewController: UIViewController {

    private var navBar: CustomNavigationBar!
    private var tableView: UITableView!
    private var tableFooter: UserPorifleTableFooter!
    private let viewModel = UserProfileViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
        tableFooter.doneButtonTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }

    private func bindViewModel() {
        viewModel.getUserDataSuccess = { [weak self] in
            self?.tableView.reloadData()
            self?.tableFooter.enableDoneButton()
        }
        viewModel.getUserData()
    }

    private func setupView() {
        view.backgroundColor = .white
        setupNavBar()
        setupTableView()
        setupConstraints()
    }

    private func setupNavBar() {
        let settings = NavigationBarSetting(backgroundColor: UIColor.rgba(255, 255, 255, 1),
                                            title: "Thông tin cá nhân",
                                            shouldShowRightBarButton: false,
                                            backButtonAction: { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        })
        navBar = CustomNavigationBar(settings: settings)
    }

    private func setupTableView() {
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.allowsSelection = false
        tableView.keyboardDismissMode = .interactive
        tableView.backgroundColor = UIColor.rgba(255, 255, 255, 1)
        tableView.dataSource = self
        tableView.delegate = self
        tableFooter = UserPorifleTableFooter(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        tableView.tableFooterView = tableFooter
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: CGFloat.leastNormalMagnitude))
        tableView.register(UserProfileNormalTableCell.self, forCellReuseIdentifier: UserProfileNormalTableCell.identifier)
        tableView.register(UserProfileGenderTableCell.self, forCellReuseIdentifier: UserProfileGenderTableCell.identifier)
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

extension UserProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.userInfo == nil ? 0 : UserInfoType.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let type = UserInfoType(rawValue: indexPath.row),
              let userInfo = viewModel.userInfo,
              let userLocation = viewModel.userLocation else {
            return UITableViewCell()
        }

        if type == .gender {
            let cell = tableView.dequeueReusableCell(withIdentifier: UserProfileGenderTableCell.identifier, for: indexPath) as! UserProfileGenderTableCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: UserProfileNormalTableCell.identifier, for: indexPath) as! UserProfileNormalTableCell
            cell.viewModel = UserProfileNormalCellViewModel(type: type, userInfo: userInfo, userLocation: userLocation)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let type = UserInfoType(rawValue: indexPath.row) else { return .zero }
        if type == .gender {
            return 103
        } else {
            return 79
        }
    }
}
