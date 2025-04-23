//
//  HomeWorker.swift
//  Home
//
//  Created by Asadbek Yoldoshev on 4/3/25.
//

import Foundation
import Core

protocol HomeWorkeringProtocol {
    func fetchUser() async throws -> UserModel
    func fetchUserBalanceAndExpenses() async throws -> [UserBalanceAndExpensesModel]
    func fetchBanners() async throws -> [BannerModel]
    func fetchPopularBanners() async throws -> [BannerModel]
    func featchSenderModel() async throws -> SenderModel
}

final class HomeWorker {
    
    init() {  }
}

extension HomeWorker {
    
}

//MARK: - HomeWorkeringProtocol Implementation
extension HomeWorker: HomeWorkeringProtocol {
    
    func fetchUser() async throws -> UserModel {
        //        return try await NetworkService.shared.request(
        //            url: "/user/profile",
        //            decode: UserModel.self,
        //            method: .get
        //        )
        return UserModel(id: 1, fullName: "Asadbek Yoldoshev" )
    }
    
    func fetchUserBalanceAndExpenses() async throws -> [UserBalanceAndExpensesModel] {
        //        let body = ["userId": 1]
        //
        //        return try await NetworkService.shared.request(
        //            url: "",
        //            decode: UserBalanceAndExpensesModel.self,
        //            method: .post,
        //            body: body
        //        )
        
        return MockData.cards.map { UserBalanceAndExpensesModel(cartId: $0) }
    }
    
    func fetchBanners() async throws -> [BannerModel] {
        //        return try await NetworkService.shared.request(
        //            url: "",
        //            decode: [BannerModel].self,
        //            method: .get
        //        )
        return [
            BannerModel(
                id: 1,
                media: BannerMedia(
                    id: 1,
                    src: "https://png.pngtree.com/background/20210711/original/pngtree-light-green-japanese-furniture-home-improvement-carnival-e-commerce-banner-picture-image_1076913.jpg",
                    type: "",
                    title: "10 квартир — и одна\nможет стать вашей!"
                )
            )
        ]
    }
    
    func fetchPopularBanners() async throws -> [BannerModel] {
        //        return try await NetworkService.shared.request(
        //            url: "",
        //            decode: [BannerModel].self,
        //            method: .get
        //        )
        return [
            BannerModel(
                id: 1,
                media: BannerMedia(
                    id: 1,
                    src: "https://www.shutterstock.com/shutterstock/photos/2483938673/display_1500/stock-photo-interior-of-living-room-with-sofa-armchair-table-and-glowing-lamps-in-evening-2483938673.jpg",
                    type: "",
                    title: "мой дом"
                )
            ),
            BannerModel(
                id: 2,
                media: BannerMedia(
                    id: 2,
                    src: "https://www.1ab.ru/upload/iblock/50d/zh281zirumh8c3exv9sk1pq0qs5qbsni/banner-dlya-stranitsy-stati.png",
                    type: "",
                    title: "благотворительность в Payme"
                )
            )
        ]
    }
    
    func featchSenderModel() async throws -> SenderModel {
        let user = try await fetchUser()
        let balanceModels = try await fetchUserBalanceAndExpenses()
        
        let senderCards = balanceModels.map { $0.cartId }
        
        guard let selectedCard = senderCards.first else {
            throw NSError(domain: "NoCardsFound", code: -1, userInfo: [NSLocalizedDescriptionKey: "У пользователя нет карт"])
        }
        
        let model = SenderModel(
            user: user,
            senderCards: senderCards,
            selectedCard: selectedCard
        )
        
        SenderModelCacheImpl.shared.save(sender: model)
        
        return model
    }
}
