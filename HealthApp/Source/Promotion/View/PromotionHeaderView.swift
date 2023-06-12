//
//  PromotionHeaderView.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 09/06/2023.
//

import UIKit

enum PromotionOption: Int {
    case category
    case filter

    var topTitle: String {
        switch self {
            case .category:
                return "Danh mục"
            case .filter:
                return "Lọc và phân loại"
        }
    }

    var bottomTitle: String {
        switch self {
            case .category:
                return "Khuyến mãi"
            case .filter:
                return "Mới nhất"
        }
    }
}

class PromotionHeaderView: UIView {

    private var collectionView: UICollectionView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PromotionCollectionHeaderCell.self,
                                forCellWithReuseIdentifier: PromotionCollectionHeaderCell.identifier)
    }

}

extension PromotionHeaderView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PromotionCollectionHeaderCell.identifier, for: indexPath) as! PromotionCollectionHeaderCell
        guard let option = PromotionOption(rawValue: indexPath.row) else { return cell }
        cell.option = option
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2, height: collectionView.frame.height)
    }
}
