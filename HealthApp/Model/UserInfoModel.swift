//
//  UserInfoModel.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 12/06/2023.
//

import Foundation

struct UserResponse: Codable {
    let status: Int
    let message: String
    let code: Int
    let data: UserInfo
}

struct UserInfo: Codable {
    let id: Int
    let name: String
    let lastName: String
    let username: String
    let contactEmail: String
    let phone: String
    let address: String
    let provinceCode: String
    let districtCode: String
    let wardCode: String
    let bloodName: String
    let birthDate: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case lastName = "last_name"
        case username
        case contactEmail = "contact_email"
        case phone, address
        case provinceCode = "province_code"
        case districtCode = "district_code"
        case wardCode = "ward_code"
        case birthDate = "birth_date"
        case bloodName = "blood_name"
    }
}
