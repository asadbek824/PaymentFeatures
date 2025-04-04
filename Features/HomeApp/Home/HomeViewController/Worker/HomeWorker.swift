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
}
