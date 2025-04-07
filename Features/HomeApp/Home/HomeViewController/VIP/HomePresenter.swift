//
//  HomePresenter.swift
//  Home
//
//  Created by Asadbek Yoldoshev on 4/3/25.
//

import Foundation
import Core

protocol HomePresentetionProtocol {
    func display(user: UserModel, carts: [UserBalanceAndExpensesModel], banners: [BannerModel])
}

final class HomePresenter {
    
    weak var view: HomeViewDisplayProtocol?
    
    init() {  }
}

//MARK: - HomePresentetionProtocol Implementation
extension HomePresenter: HomePresentetionProtocol {
    
    func display(user: UserModel, carts: [UserBalanceAndExpensesModel], banners: [BannerModel]) {
        let initials = String(user.fullName.split(separator: " ").compactMap { $0.first }.prefix(2))
        
        let totalBalance = carts.reduce(0) { $0 + $1.cartId.balance }
        let totalExpenses = carts.reduce(0) { $0 + $1.cartId.expenses }
        let currency = carts.first?.cartId.currency ?? "сум"
        
        let sections: [HomeSectionItem] = [
            .balance(BalanceViewModel(
                balance: format(totalBalance),
                expenses: "- \(format(totalExpenses, fraction: true))",
                currency: currency,
                isHidden: false
            )),
            .paymeGo([
                PaymeGoItemViewModel(image: Asset.Image.cartholder, title: "Мои карты"),
                PaymeGoItemViewModel(image: Asset.Image.paymego, title: "Payme Go"),
                PaymeGoItemViewModel(image: Asset.Image.scaner, title: "QR оплата")
            ]),
            .banner(BannerViewModel(
                imageUrl: banners.first?.media.src ?? "",
                title: banners.first?.media.title ?? ""
            )),
            .finicalServices([
                FinicalServicesViewModel(image: Asset.Image.transfer, title: "перевести средства"),
                FinicalServicesViewModel(image: Asset.Image.tbsbank, title: "кредит от TBC Bank")
            ])
        ]
        
        DispatchQueue.main.async {
            self.view?.display(sections: sections)
            self.view?.displayUserInitials(initials)
        }
        
    }
}

//MARK: - NumberFormatters
private extension HomePresenter {
    func format(_ amount: Double, fraction: Bool = false) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.minimumFractionDigits = fraction ? 2 : 0
        formatter.maximumFractionDigits = fraction ? 2 : 0
        return formatter.string(from: NSNumber(value: amount)) ?? "0"
    }
}

