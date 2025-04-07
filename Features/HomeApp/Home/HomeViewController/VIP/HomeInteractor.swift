//
//  HomeInteractor.swift
//  Home
//
//  Created by Asadbek Yoldoshev on 4/3/25.
//

import Foundation

protocol HomeBusseinessProtocol {
    func loadAllData()
}

final class HomeInteractor {
    
    private let presenter: HomePresentetionProtocol
    private let worker: HomeWorkeringProtocol
    
    init(presenter: HomePresentetionProtocol, worker: HomeWorkeringProtocol) {
        self.presenter = presenter
        self.worker = worker
    }
}

//MARK: - HomeBusseinessProtocol Implementation
extension HomeInteractor: HomeBusseinessProtocol {
    
    func loadAllData() {
        Task {
            async let user = worker.fetchUser()
            async let carts = worker.fetchUserBalanceAndExpenses()
            async let banners = worker.fetchBanners()
            async let popularBanners = worker.fetchPopularBanners()
            
            do {
                try await presenter.display(
                    user: user,
                    carts: carts,
                    banners: banners,
                    popularBanners: popularBanners
                )
            } catch {
                print("Ошибка:", error)
            }
        }
    }
}
