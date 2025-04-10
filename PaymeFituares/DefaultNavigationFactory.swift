//
//  DefaultNavigationFactory.swift
//  PaymeFituares
//
//  Created by Asadbek Yoldoshev on 4/9/25.
//

import Home
import Payment
import SwiftUI
import Services
import NavigationCoordinator
import Core

final class DefaultNavigationFactory: NavigationFactory {
    func viewController(for route: AppRoute) -> UIViewController {
        switch route {
        case .home: return HomeAssemblyImpl.assemble()
        case .payments: return UIHostingController(rootView: PaymentsView())
        case .services: return UIHostingController(rootView: ServicesView())
        case .payShare:
            let vc = UIHostingController(rootView: PayShareView())
            vc.hidesBottomBarWhenPushed = true
            return vc 
        case .receipt(let model):
            let vc = UIHostingController(
                rootView: ReceiptView(model: model) {
                    AppNavigationCoordinator.shared.popToRootAndShowTab(index: 0)
                }
            )
            vc.hidesBottomBarWhenPushed = true
            return vc
        case .detail(let title):
            let vc = UIViewController()
            vc.view.backgroundColor = .white
            vc.title = title
            return vc
        @unknown default: return UIViewController()
        }
    }
}
