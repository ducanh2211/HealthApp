//
//  HomeFeedViewModel.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 09/06/2023.
//

import Foundation

class HomeFeedViewModel {

    var articleList = [Article]()
    var promotionList = [Promotion]()
    var doctorList = [Doctor]()
    var getDataSuccess: (() -> Void)?

    func getHomeData() {
        HomeFeedAPIService.shared.requestHomeFeed { [weak self] result in
            switch result {
                case .success(let homeModel):
                    self?.articleList = homeModel.data.articleList
                    self?.promotionList = homeModel.data.promotionList
                    self?.doctorList = homeModel.data.doctorList
                    self?.getDataSuccess?()
                case .failure(let error):
                    print("DEBUG: get home data error: \(error)")
            }
        }
    }
}
