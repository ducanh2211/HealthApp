//
//  LocationResponse.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 12/06/2023.
//

import Foundation

struct LocationResponse: Codable {
    let status: Int
    let message: String
    let code: Int
    let data: UserLocation
}

struct UserLocation: Codable {
    let provinceName: String
    let districtName: String
    let wardName: String

    enum CodingKeys: String, CodingKey {
        case provinceName = "province_name"
        case districtName = "district_name"
        case wardName = "ward_name"
    }
}
