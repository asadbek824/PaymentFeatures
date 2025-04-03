//
//  HomePresenter.swift
//  Home
//
//  Created by Asadbek Yoldoshev on 4/3/25.
//

import Foundation
import Core

protocol HomePresentetionProtocol {
    func displayUser(user: UserModel)
}

final class HomePresenter {
    
    weak var view: HomeViewDisplayProtocol?
    
    init() {  }
}

extension HomePresenter: HomePresentetionProtocol {
    
    func displayUser(user: UserModel) {
        let components = user.fullName.components(separatedBy: " ")
        let initials = components.prefix(2).compactMap { $0.first.map { String($0).uppercased() } }.joined()
        DispatchQueue.main.async {
            self.view?.updateUserInitials(initials)
        }
    }
}


