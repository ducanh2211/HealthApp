//
//  DoctorResponse.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 09/06/2023.
//

import Foundation

struct DoctorResponse: Codable {
    let status: Int
    let message: String
    let code: Int
    let data: DoctorData
}

struct DoctorData: Codable {
    let items: [Doctor]
}

struct Doctor: Codable {
    let id: Int
    let fullName: String
    let name: String
    let avatar: String
    let majorsName: String
    let ratioStar: Double
    let numberOfStars: Int

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case name
        case avatar
        case majorsName = "majors_name"
        case ratioStar = "ratio_star"
        case numberOfStars = "number_of_stars"
    }
}
