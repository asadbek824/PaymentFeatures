//
//  HomeInteractor.swift
//  Home
//
//  Created by Asadbek Yoldoshev on 4/3/25.
//

import Foundation

protocol HomeBusseinessProtocol {
    func loadUserData() async
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
    
    func loadUserData() async {
        do {
            let user = try await worker.fetchUser()
            presenter.displayUser(user: user)
        } catch {
            print("Ошибка загрузки пользователя:", error)
        }
    }
}
