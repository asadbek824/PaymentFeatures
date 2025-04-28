//
//  HomePresenter.swift
//  Home
//
//  Created by Asadbek Yoldoshev on 4/3/25.
//

import Foundation
import Core
import DesignSystem

protocol HomePresentetionProtocol {
    func display(
        user: UserModel,
        carts: [UserBalanceAndExpensesModel],
        banners: [BannerModel],
        popularBanners: [BannerModel]
    )
    func payShareSenderModel(senderModel: SenderModel)
    func payShareIntroPresent()
}

final class HomePresenter {
    
    weak var view: HomeViewDisplayProtocol?
    
    init() {  }
}

//MARK: - HomePresentetionProtocol Implementation
extension HomePresenter: HomePresentetionProtocol {
    
    func display(
        user: UserModel,
        carts: [UserBalanceAndExpensesModel],
        banners: [BannerModel],
        popularBanners: [BannerModel]
    ) {
        let initials = String(user.fullName.split(separator: " ").compactMap { $0.first }.prefix(2))
        
        let totalBalance = carts.reduce(0) { $0 + $1.cartId.balance }
        let totalExpenses = carts.reduce(0) { $0 + $1.cartId.expenses }
        let currency = carts.first?.cartId.currency ?? "сум"
        let popularBanners = popularBanners.map {
            PopularViewModel(id: $0.media.id, image: $0.media.src ?? "", title: $0.media.title)
        }
        
        let sections: [HomeSectionItem] = [
            .balance(BalanceViewModel(
                balance: format(totalBalance),
                expenses: "- \(format(totalExpenses, fraction: true))",
                currency: currency,
                isHidden: false
            )),
            .paymeGo([
                PaymeGoItemViewModel(image: AssetsKitDummy.Image.cartholder, title: "Мои карты"),
                PaymeGoItemViewModel(image: AssetsKitDummy.Image.paymego, title: "Payme Go"),
                PaymeGoItemViewModel(image: AssetsKitDummy.Image.paysharegray, title: "Payme Share"),
                PaymeGoItemViewModel(image: AssetsKitDummy.Image.scaner, title: "QR оплата")
            ]),
            .payShareIntro(
                PayShareIntroViewModel(image: AssetsKitDummy.Image.payshareintro, title: "Моментальные\nпереводы рядом")
            ),
            .banner(BannerViewModel(
                imageUrl: banners.first?.media.src ?? "",
                title: banners.first?.media.title ?? ""
            )),
            .finicalServices([
                FinicalServicesViewModel(image: AssetsKitDummy.Image.transfer, title: "перевести средства"),
                FinicalServicesViewModel(image: AssetsKitDummy.Image.tbsbank, title: "кредит от TBC Bank")
            ]),
            .popular(popularBanners)
        ]
        
        DispatchQueue.main.async {
            self.view?.display(sections: sections)
            self.view?.displayUserInitials(initials)
        }
        
    }
    
    func payShareSenderModel(senderModel: SenderModel) {
        DispatchQueue.main.async {
            self.view?.payShareTapped(senderModel: senderModel)
        }
    }
    
    func payShareIntroPresent() {
        DispatchQueue.main.async {
            self.view?.payShareIntroTapped()
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

