//
//  HomeFeedAPIService.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 09/06/2023.
//

import Foundation

class HomeFeedAPIService: APIService {

    static let shared = HomeFeedAPIService()

    func requestHomeFeed(completion: @escaping (Result<HomeResponse, NetworkError>) -> Void) {
        makeRequest(endpoint: HomeFeedEndpoint.home, completion: completion)
    }

    func requestNews(completion: @escaping (Result<ArticleResponse, NetworkError>) -> Void) {
        makeRequest(endpoint: HomeFeedEndpoint.news, completion: completion)
    }

    func requestPromotion(completion: @escaping (Result<PromotionResponse, NetworkError>) -> Void) {
        makeRequest(endpoint: HomeFeedEndpoint.promotion, completion: completion)
    }

    func requestDoctors(completion: @escaping (Result<DoctorResponse, NetworkError>) -> Void) {
        makeRequest(endpoint: HomeFeedEndpoint.doctors, completion: completion)
    }

    func requestUserInfo(completion: @escaping (Result<UserResponse, NetworkError>) -> Void) {
        makeRequest(endpoint: HomeFeedEndpoint.user, completion: completion)
    }

    func requestUserLocation(province: String, district: String, ward: String, completion: @escaping (Result<LocationResponse, NetworkError>) -> Void) {
        makeRequest(endpoint: HomeFeedEndpoint.location(province: province, district: district, ward: ward), completion: completion)
    }
}
