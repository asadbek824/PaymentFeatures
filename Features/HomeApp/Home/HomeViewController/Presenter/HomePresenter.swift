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
    func displayCarts(carts: [UserBalanceAndExpensesModel])
    func displayBanners(banners: [BannerModel])
}

final class HomePresenter {
    
    weak var view: HomeViewDisplayProtocol?
    
    init() {  }
}

//MARK: - HomePresentetionProtocol Implementation
extension HomePresenter: HomePresentetionProtocol {
    
    func displayUser(user: UserModel) {
        let components = user.fullName.components(separatedBy: " ")
        let initials = components.prefix(2).compactMap { $0.first.map { String($0).uppercased() } }.joined()
        DispatchQueue.main.async {
            self.view?.updateUserInitials(initials)
        }
    }
    
    func displayCarts(carts: [UserBalanceAndExpensesModel]) {
        let totalBalance = carts.reduce(0) { $0 + $1.cartId.balance }
        let totalExpenses = carts.reduce(0) { $0 + $1.cartId.expenses }
        let currency = carts.first?.cartId.currency ?? "сум"
        
        let formattedBalance = formatBalance(totalBalance, showFraction: false)
        let formattedExpenses = formatBalance(totalExpenses, showFraction: true)
        
        DispatchQueue.main.async {
            self.view?.updateUserBalanceAndExpensess(formattedBalance, formattedExpenses, currency)
        }
    }
    
    func displayBanners(banners: [BannerModel]) {
        guard let firstBanner = banners.first else { return }
        let imageUrl = firstBanner.media.src ?? ""
        let title = firstBanner.media.title
        view?.updateBannerImageAndTitle(imageUrl, title)
    }
}

//MARK: - NumberFormatters
private extension HomePresenter {
    func formatBalance(_ amount: Double, showFraction: Bool) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.minimumFractionDigits = showFraction ? 2 : 0
        formatter.maximumFractionDigits = showFraction ? 2 : 0

        return formatter.string(from: NSNumber(value: amount)) ?? "0"
    }
}

