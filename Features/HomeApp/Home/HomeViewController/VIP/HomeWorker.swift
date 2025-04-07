//
//  HomeWorker.swift
//  Home
//
//  Created by Asadbek Yoldoshev on 4/3/25.
//

import Foundation
import NetworkManager
import Core

protocol HomeWorkeringProtocol {
    func fetchUser() async throws -> UserModel
    func fetchUserBalanceAndExpenses() async throws -> [UserBalanceAndExpensesModel]
    func fetchBanners() async throws -> [BannerModel]
    func fetchPopularBanners() async throws -> [BannerModel]
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
        return UserModel(id: 1, fullName: "Asadbek Yoldoshev")
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
        
        return [
            UserBalanceAndExpensesModel(
                cartId:
                    UserCarts(
                        cartId: 1,
                        balance: 820360.48,
                        expenses: 1200210.24,
                        cartNumber: "8600060905809696",
                        cartName: "Xalq Bank",
                        currency: "сум"
                    )
            ),
            UserBalanceAndExpensesModel(
                cartId:
                    UserCarts(
                        cartId: 2,
                        balance: 1792.76,
                        expenses: 200210.24,
                        cartNumber: "8600060905809999",
                        cartName: "Asadbek Yo'ldoshev",
                        currency: "сум"
                    )
            ),
            UserBalanceAndExpensesModel(
                cartId:
                    UserCarts(
                        cartId: 3,
                        balance: 578.75,
                        expenses: 100210.24,
                        cartNumber: "8600060905807777",
                        cartName: "Asadbek Yo'ldoshev",
                        currency: "сум"
                    )
            ),
        ]
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
}
