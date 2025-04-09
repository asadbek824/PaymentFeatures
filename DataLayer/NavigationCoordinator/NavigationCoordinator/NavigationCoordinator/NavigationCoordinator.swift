//
//  NavigationCoordinator.swift
//  NavigationCoordinator
//
//  Created by Asadbek Yoldoshev on 4/9/25.
//

import UIKit

public protocol NavigationFactory {
    func viewController(for route: AppRoute) -> UIViewController
}

public final class AppNavigationCoordinator {
    public static let shared = AppNavigationCoordinator()

    private var navigationController: UINavigationController?
    private var factory: NavigationFactory?

    public func setRoot(navigationController: UINavigationController, factory: NavigationFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }

    public func navigate(to route: AppRoute) {
        guard let vc = factory?.viewController(for: route) else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
}
