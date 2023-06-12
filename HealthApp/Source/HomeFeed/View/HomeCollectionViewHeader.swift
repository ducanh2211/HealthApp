//
//  HomeCollectionViewHeader.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 09/06/2023.
//

import UIKit

protocol HomeCollectionViewHeaderDelegate: AnyObject {
    func didTapSeeAllButton(type: HomeFeedController.SectionType)
}

class HomeCollectionViewHeader: UICollectionReusableView {

    static var identifier: String {
        return String(describing: self)
    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.rgba(36, 42, 97, 1)
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 1
        return label
    }()

    private lazy var seeAllButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Xem tất cả", for: .normal)
        btn.setTitleColor(UIColor.rgba(44, 134, 103, 1), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        btn.setImage(UIImage(named: "next"), for: .normal)
        btn.titleEdgeInsets.left = -15
        btn.semanticContentAttribute = .forceRightToLeft
        btn.addTarget(self, action: #selector(didTapSeeAllButton), for: .touchUpInside)
        return btn
    }()

    var type: HomeFeedController.SectionType? {
        didSet {
            titleLabel.text = type?.description
        }
    }
    weak var delegate: HomeCollectionViewHeaderDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func didTapSeeAllButton() {
        guard let type = type else { return }
        delegate?.didTapSeeAllButton(type: type)
    }

    private func setup() {
        addSubview(titleLabel)
        addSubview(seeAllButton)

        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            seeAllButton.rightAnchor.constraint(equalTo: rightAnchor),
            seeAllButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
