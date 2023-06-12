//
//  DoctorController.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 09/06/2023.
//

import UIKit

class DoctorController: UIViewController {

    private var navBar: CustomNavigationBar!
    private var tableView: UITableView!
    private let viewModel = DoctorViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }

    private func bindViewModel() {
        viewModel.getDataSuccess = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.getDoctorList()
    }

    private func setupView() {
        view.backgroundColor = .white
        setupNavBar()
        setupTableView()
        setupConstraints()
    }

    private func setupNavBar() {
        let settings = NavigationBarSetting(backgroundColor: UIColor.rgba(255, 255, 255, 1),
                                            title: "Bác sĩ ",
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
        //        tableView.delegate = self
        tableView.estimatedSectionHeaderHeight = 260
        tableView.estimatedRowHeight = 180
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.register(DoctorTableViewCell.self,
                           forCellReuseIdentifier: DoctorTableViewCell.identifier)
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

extension DoctorController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.doctorList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DoctorTableViewCell.identifier, for: indexPath) as! DoctorTableViewCell
        cell.doctor = viewModel.doctorList[indexPath.row]
        return cell
    }
}
