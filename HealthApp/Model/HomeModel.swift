//
//  HomeModel.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 09/06/2023.
//

import Foundation

struct HomeModel: Codable {
    let status: Int
    let message: String
    let code: Int
    let data: HomeData
}

struct HomeData: Codable {
    let articleList: [Article]
    let promotionList: [Promotion]
    let doctorList: [Doctor]
}
