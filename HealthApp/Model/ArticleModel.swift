//
//  ArticleModel.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 09/06/2023.
//

import Foundation

struct ArticleModel: Codable {
    let status: Int
    let message: String
    let code: Int
    let data: ArticleData
}

struct ArticleData: Codable {
    let items: [Article]
}

struct Article: Codable {
    let id: Int
    let title: String
    let picture: String
    let pictureCaption: String
    let createdAt: String
    let link: String

    enum CodingKeys: String, CodingKey {
        case id, title, picture
        case pictureCaption = "picture_caption"
        case createdAt = "created_at"
        case link
    }
}
