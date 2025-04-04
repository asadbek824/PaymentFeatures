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
}
