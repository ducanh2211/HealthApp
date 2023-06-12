//
//  PromotionResponse.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 09/06/2023.
//

import Foundation

struct PromotionResponse: Codable {
    let status: Int
    let message: String
    let code: Int
    let data: PromotionData
}

struct PromotionData: Codable {
    let items: [Promotion]
}

struct Promotion: Codable {
    let id: Int
    let name: String
    let content: String
    let picture: String
    let createdAt: String
    let link: String

    enum CodingKeys: String, CodingKey {
        case id, name, content, picture
        case createdAt = "created_at"
        case link
    }
}
