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
            let payShareView = PayShareView()
            let vc = UIHostingController(rootView: payShareView)
            vc.hidesBottomBarWhenPushed = true
            return vc
        case .receipt(let model):
            let view = ReceiptView(model: model) {
                AppNavigationCoordinator.shared.popToRoot()
                AppNavigationCoordinator.shared.popToRoot(animated: true)
            }
            let vc = UIHostingController(rootView: view)
            vc.hidesBottomBarWhenPushed = true
            vc.navigationController?.setNavigationBarHidden(true, animated: false)
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
