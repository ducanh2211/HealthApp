//
//  PromotionCollectionHeaderCell.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 09/06/2023.
//

import UIKit

class PromotionCollectionHeaderCell: UICollectionViewCell {

    static var identifier: String {
        return String(describing: self)
    }

    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 1
        label.textColor = UIColor.rgba(150, 155, 171, 1)
        label.text = "Danh mục"
        return label
    }()

    private let promotionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor.rgba(24, 25, 31, 1)
        label.text = "Khuyến mãi"
        return label
    }()

    private let expandButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "expand"), for: .normal)
        button.tintColor = UIColor.rgba(150, 155, 171, 1)
        return button
    }()

    var option: PromotionOption? {
        didSet {
            configure()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        guard let option = option else { return }
        categoryLabel.text = option.topTitle
        promotionLabel.text = option.bottomTitle
    }

    private func setup() {
        let stack = UIStackView(arrangedSubviews: [categoryLabel, promotionLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stack)
        contentView.addSubview(expandButton)

        NSLayoutConstraint.activate([
            stack.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            stack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            expandButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            expandButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
