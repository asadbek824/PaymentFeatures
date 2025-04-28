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

    public func navigate(
        to route: AppRoute,
        from navigationController: UINavigationController?
    ) {
        let vc = factory.makeViewController(for: route)
        
        handleNavigation(
            for: route,
            viewController: vc,
            navigationController: navigationController
        )
    }

    private func handleNavigation(
        for route: AppRoute,
        viewController: UIViewController,
        navigationController: UINavigationController?
    ) {
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
        guard
            let scene = UIApplication.shared.connectedScenes
                .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
            let window = scene.windows.first,
            let rootViewController = window.rootViewController,
            let presentedViewController = rootViewController.presentedViewController
        else {
            return
        }

        presentedViewController.dismiss(animated: animated)
    }
}
