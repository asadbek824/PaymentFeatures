//
//  HomeInteractor.swift
//  Home
//
//  Created by Asadbek Yoldoshev on 4/3/25.
//

import Core
import Foundation

protocol HomeBusseinessProtocol {
    func loadAllData()
    func payShareButtonTapped()
    func payShareIntroSectionTapped()
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
    
    func payShareIntroSectionTapped() {
        presenter.payShareIntroPresent()
    }
    
    func payShareButtonTapped() {
        Task {
            async let senderModel = worker.featchSenderModel()
            
            do {
                try await presenter.payShareSenderModel(senderModel: senderModel)
            } catch {
                Logger.log("Error presenting sender model: \(error)")
            }
        }
    }
    
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
                Logger.log("Error loading cells: \(error)")
            }
        }
    }
}
