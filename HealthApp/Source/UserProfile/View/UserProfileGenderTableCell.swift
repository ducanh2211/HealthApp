//
//  UserProfileGenderTableCell.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 12/06/2023.
//

import UIKit

class UserProfileGenderTableCell: UITableViewCell {

    static var identifier: String {
        return String(describing: self)
    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor =  UIColor.rgba(71, 74, 87, 1)
        label.textAlignment = .left
        label.text = "Giới tính"
        label.numberOfLines = 1
        return label
    }()

    private let segmentControl: UISegmentedControl = {
        let segment = UISegmentedControl()
        segment.insertSegment(with: UIImage(named: "ic-male"), at: 1, animated: true)
        segment.insertSegment(with: UIImage(named: "ic-female"), at: 2, animated: true)
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.selectedSegmentIndex = 0
        segment.setTitleTextAttributes([.foregroundColor: UIColor.rgba(71, 74, 87, 1)], for: .normal)
        segment.setTitleTextAttributes([.foregroundColor: UIColor.rgba(44, 134, 103, 1)], for: .selected)
        return segment
    }()

    //MARK: - View LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    //MARK: - Helpers
    func setup() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(segmentControl)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 26),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),

            segmentControl.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            segmentControl.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            segmentControl.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            segmentControl.heightAnchor.constraint(equalTo: segmentControl.widthAnchor, multiplier: 44 / 327)
        ])

    }

}
