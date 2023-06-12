//
//  HomeFeedController.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 08/06/2023.
//

import UIKit

extension HomeFeedController {
    enum SectionType: Int, CaseIterable {
        case news
        case promotion
        case doctors

        var description: String {
            switch self {
                case .news:
                    return "Tin tức"
                case .promotion:
                    return "Khuyến mãi"
                case .doctors:
                    return "Giới thiệu bác sĩ"
            }
        }
    }
}

class HomeFeedController: UIViewController {

    var headerView: HomeFeedHeader!
    var collectionView: UICollectionView!
    let viewModel = HomeFeedViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }

    private func bindViewModel() {
        viewModel.getDataSuccess = { [weak self] in
            self?.collectionView.reloadData()
        }
        viewModel.getHomeData()
    }
}

// MARK: - HomeFeedHeaderDelegate

extension HomeFeedController: HomeFeedHeaderDelegate {
    func didTapAvatarImage() {

    }
}

// MARK: - HomeCollectionViewHeaderDelegate

extension HomeFeedController: HomeCollectionViewHeaderDelegate {
    func didTapSeeAllButton(type: SectionType) {
        switch type {
            case .news:
                let vc = NewsController()
                navigationController?.pushViewController(vc, animated: true)
            case .promotion:
                let vc = PromotionController()
                navigationController?.pushViewController(vc, animated: true)
            case .doctors:
                let vc = DoctorController()
                navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension HomeFeedController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SectionType.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let type = SectionType(rawValue: section) else {
            return 0
        }
        switch type {
            case .news:
                return viewModel.articleList.count
            case .promotion:
                return viewModel.promotionList.count
            case .doctors:
                return viewModel.doctorList.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let type = SectionType(rawValue: indexPath.section) else {
            return UICollectionViewCell()
        }

        switch type {
            case .news:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: HomeNewsCollectionViewCell.identifier,
                    for: indexPath) as! HomeNewsCollectionViewCell
                cell.article = viewModel.articleList[indexPath.item]
                return cell
            case .promotion:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: HomePromotionCollectionViewCell.identifier,
                    for: indexPath) as! HomePromotionCollectionViewCell
                cell.promotion = viewModel.promotionList[indexPath.item]
                return cell
            case .doctors:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: HomeDoctorsCollectionViewCell.identifier,
                    for: indexPath) as! HomeDoctorsCollectionViewCell
                cell.doctor = viewModel.doctorList[indexPath.item]
                return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: HomeCollectionViewHeader.identifier,
                for: indexPath) as! HomeCollectionViewHeader
            guard let type = SectionType(rawValue: indexPath.section) else { return header }
            header.type = type
            header.delegate = self
            return header
        }
        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let type = SectionType(rawValue: indexPath.section) else { return }
        switch type {
            case .news:
                let article = viewModel.articleList[indexPath.item]
                let vc = ArticleDetailController(link: article.link)
                navigationController?.pushViewController(vc, animated: true)
            case .promotion:
                let promotion = viewModel.promotionList[indexPath.item]
                let vc = ArticleDetailController(link: promotion.link)
                navigationController?.pushViewController(vc, animated: true)
            case .doctors:
                break
        }
    }
}
