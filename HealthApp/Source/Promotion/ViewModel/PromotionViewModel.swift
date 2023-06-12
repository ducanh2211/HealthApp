//
//  PromotionDetailsViewModel.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 09/06/2023.
//

import Foundation

class PromotionViewModel {

    var promotionList = [Promotion]()
    var getDataSuccess: (() -> Void)?

    func getPromotionList() {
        HomeFeedAPIService.shared.requestPromotion { [weak self] result in
            switch result {
                case .success(let promotionModel):
                    self?.promotionList = promotionModel.data.items
                    self?.getDataSuccess?()
                case .failure(let error):
                    print("DEBUG: get aritcle error: \(error)")
            }
        }
    }

}
