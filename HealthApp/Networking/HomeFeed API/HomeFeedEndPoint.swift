//
//  HomeFeedEndPoint.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 09/06/2023.
//

import Foundation

enum HomeFeedEndpoint {
    case home
    case news
    case promotion
    case promotionDetails
    case doctors
}

extension HomeFeedEndpoint: Endpoint {
    var host: String {
        "gist.githubusercontent.com"
    }

    var path: String {
        switch self {
            case .home:
                return "/hdhuy179/f967ffb777610529b678f0d5c823352a/raw"
            case .news:
                return "/hdhuy179/84d1dfe96f2c0ab1ddea701df352a7a6/raw"
            case .promotion:
                return "/hdhuy179/ef03ed850ad56f0136fe3c5916b3280b/raw/Training_Intern_BasicApp_Promotion"
            case .promotionDetails:
                return "/hdhuy179/ef03ed850ad56f0136fe3c5916b3280b/raw/1do"
            case .doctors:
                return "/hdhuy179/9ac0a89969b46fb67bc7d1a8b94d180e/raw"
        }
    }

    var url: URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        return components.url
    }
}
