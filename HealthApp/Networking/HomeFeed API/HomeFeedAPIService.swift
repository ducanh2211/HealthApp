//
//  HomeFeedAPIService.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 09/06/2023.
//

import Foundation

class HomeFeedAPIService: APIService {

    static let shared = HomeFeedAPIService()

    func requestHomeFeed(completion: @escaping (Result<HomeModel, NetworkError>) -> Void) {
        makeRequest(endpoint: HomeFeedEndpoint.home, completion: completion)
    }

    func requestNews(completion: @escaping (Result<ArticleModel, NetworkError>) -> Void) {
        makeRequest(endpoint: HomeFeedEndpoint.news, completion: completion)
    }

    func requestPromotion(completion: @escaping (Result<PromotionModel, NetworkError>) -> Void) {
        makeRequest(endpoint: HomeFeedEndpoint.promotion, completion: completion)
    }

    func requestDoctors(completion: @escaping (Result<DoctorModel, NetworkError>) -> Void) {
        makeRequest(endpoint: HomeFeedEndpoint.doctors, completion: completion)
    }
}
