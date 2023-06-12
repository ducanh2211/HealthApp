//
//  UserProfileViewModel.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 12/06/2023.
//

import Foundation

enum UserInfoType: Int, CaseIterable {
    case name
    case lastname
    case date
    case gender
    case phoneNumber
    case email
    case city
    case district
    case ward
    case address
    case typeBlood
}

class UserProfileViewModel {
    var userInfo: UserInfo?
    var userLocation: UserLocation?
    var getUserDataSuccess: (() -> Void)?

    func getUserData() {
        HomeFeedAPIService.shared.requestUserInfo { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let userResponse):
                    let userInfo = userResponse.data
                    self.userInfo = userInfo

                    HomeFeedAPIService.shared.requestUserLocation(province: userInfo.provinceCode,
                                                                  district: userInfo.districtCode,
                                                                  ward: userInfo.wardCode) { result in
                        switch result {
                            case .success(let locationResponse):
                                self.userLocation = locationResponse.data
                                self.getUserDataSuccess?()
                            case .failure(let error):
                                print("DEBUG: requestUserLocation error: \(error)")
                        }
                    }
                case .failure(let error):
                    print("DEBUG: requestUserInfo error: \(error)")
            }
        }
    }
}

struct UserProfileNormalCellViewModel {
    let type: UserInfoType
    var userInfo: UserInfo
    var userLocation: UserLocation

    init(type: UserInfoType, userInfo: UserInfo, userLocation: UserLocation) {
        self.type = type
        self.userInfo = userInfo
        self.userLocation = userLocation
    }

    var dataString: String {
        switch type {
            case .lastname:
                return userInfo.lastName
            case .name:
                return userInfo.name
            case .date:
                return userInfo.birthDate
            case .gender:
                return "Giới tính"
            case .phoneNumber:
                return userInfo.phone
            case .email:
                return userInfo.contactEmail
            case .city:
                return userLocation.provinceName
            case .district:
                return userLocation.districtName
            case .ward:
                return userLocation.wardName 
            case .address:
                return userInfo.address
            case .typeBlood:
                return userInfo.bloodName
        }
    }

    var placeholderString: String {
        switch type {
            case .lastname:
                return "Nhập họ của bạn"
            case .name:
                return "Nhập tên của bạn"
            case .date:
                return "DD/MM/YY"
            case .gender:
                return "Giới tính"
            case .phoneNumber:
                return "Nhập số điện thoại"
            case .email:
                return "Địa chỉ email của bạn"
            case .city:
                return "Chưa cập nhập"
            case .district:
                return "Chưa cập nhập"
            case .ward:
                return "Chưa cập nhập"
            case .address:
                return "Chưa cập nhập"
            case .typeBlood:
                return "A+/B+/AB/O"
        }
    }

    var titleString: String {
        switch type {
            case .lastname:
                return "Họ *"
            case .name:
                return "Tên *"
            case .date:
                return "Ngày sinh *"
            case .gender:
                return "Giới tính"
            case .phoneNumber:
                return "Số điện thoại"
            case .email:
                return "Email"
            case .city:
                return "Tỉnh / Thành phố"
            case .district:
                return "Quận / Huyện"
            case .ward:
                return "Phường / Xã"
            case .address:
                return "Địa chỉ nơi ở"
            case .typeBlood:
                return "Nhóm máu"
        }
    }
}
