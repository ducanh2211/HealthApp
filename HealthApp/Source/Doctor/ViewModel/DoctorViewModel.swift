//
//  DoctorViewModel.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 09/06/2023.
//

import Foundation

class DoctorViewModel {

    var doctorList = [Doctor]()
    var getDataSuccess: (() -> Void)?

    func getDoctorList() {
        HomeFeedAPIService.shared.requestDoctors { [weak self] result in
            switch result {
                case .success(let doctorModel):
                    self?.doctorList = doctorModel.data.items
                    self?.getDataSuccess?()
                case .failure(let error):
                    print("DEBUG: get aritcle error: \(error)")
            }
        }
    }

}
