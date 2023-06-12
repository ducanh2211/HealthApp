//
//  NewsViewModel.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 09/06/2023.
//

import Foundation

class NewsViewModel {

    var articleList = [Article]()
    var getDataSuccess: (() -> Void)?

    func getArticleList() {
        HomeFeedAPIService.shared.requestNews { [weak self] result in
            switch result {
                case .success(let articleModel):
                    self?.articleList = articleModel.data.items
                    self?.getDataSuccess?()
                case .failure(let error):
                    print("DEBUG: get aritcle error: \(error)")
            }
        }
    }
    
}
