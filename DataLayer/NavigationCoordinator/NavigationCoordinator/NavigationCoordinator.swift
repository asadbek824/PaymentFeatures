//
//  NavigationCoordinator.swift
//  NavigationCoordinator
//
//  Created by Asadbek Yoldoshev on 4/16/25.
//

import Foundation
import UIKit
import SwiftUI

public final class AppNavigationCoordinator {

    private let factory: NavigationFactory

    public init(factory: NavigationFactory) {
        self.factory = factory
    }

    public func navigate(to route: AppRoute, from navigationController: UINavigationController?) {
        let vc = factory.makeViewController(for: route)
        handleNavigation(for: route, viewController: vc, navigationController: navigationController)
    }

    private func handleNavigation(for route: AppRoute, viewController: UIViewController, navigationController: UINavigationController?) {
        switch route.presentationStyle {
        case .push:
            navigationController?.pushViewController(viewController, animated: true)
        case .presentFullScreen:
            let presentedNavController = UINavigationController(rootViewController: viewController)
            presentedNavController.modalPresentationStyle = .fullScreen
            navigationController?.present(presentedNavController, animated: true)
        }
    }

    public func dismissPresented(animated: Bool = true) {
        UIApplication.shared.windows.first?.rootViewController?.presentedViewController?.dismiss(animated: animated)
    }
}
