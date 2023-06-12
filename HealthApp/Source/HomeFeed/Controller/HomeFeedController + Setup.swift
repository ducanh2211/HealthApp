//
//  HomeFeedController + Setup.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 09/06/2023.
//

import UIKit

extension HomeFeedController {
    func setupView() {
        navigationController?.isNavigationBarHidden = true
        setupHeaderView()
        setupCollectionView()
        setupConstraints()
    }

    private func setupHeaderView() {
        headerView = HomeFeedHeader()
        headerView.delegate = self
    }

    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollecetionViewLayout())
        collectionView.layer.cornerRadius = 15
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HomeNewsCollectionViewCell.self,
                                forCellWithReuseIdentifier: HomeNewsCollectionViewCell.identifier)
        collectionView.register(HomePromotionCollectionViewCell.self,
                                forCellWithReuseIdentifier: HomePromotionCollectionViewCell.identifier)
        collectionView.register(HomeDoctorsCollectionViewCell.self,
                                forCellWithReuseIdentifier: HomeDoctorsCollectionViewCell.identifier)
        collectionView.register(HomeCollectionViewHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: HomeCollectionViewHeader.identifier)
    }

    private func setupConstraints() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            headerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            headerView.heightAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 143/375),

            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -20),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func createCollecetionViewLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout {
            [weak self] sectionIndex, layoutEnvironment -> NSCollectionLayoutSection? in
            switch SectionType(rawValue: sectionIndex) {
                case .news:
                    return self?.createNewsSection()
                case .promotion:
                    return self?.createNewsSection()
                case .doctors:
                    return self?.createDoctorsSection()
                default:
                    return nil
            }
        }
        return layout
    }

    private func createNewsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(258),
                                               heightDimension: .absolute(220))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitem: item,
                                                     count: 1)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 12
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .absolute(60))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }

    private func createDoctorsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(121),
                                               heightDimension: .absolute(185))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitem: item,
                                                     count: 1)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 12
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .absolute(60))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }
}
