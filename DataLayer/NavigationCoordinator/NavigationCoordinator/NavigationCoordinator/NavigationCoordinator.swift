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

    private var defaultNavigationController: UINavigationController?
    private var factory: NavigationFactory?
    private var tabBarController: UITabBarController?

    public func setRoot(navigationController: UINavigationController, factory: NavigationFactory) {
        self.defaultNavigationController = navigationController
        self.factory = factory
    }
    
    public func setTabBarController(_ tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }

    public func navigate(to route: AppRoute, in navigationController: UINavigationController? = nil, animated: Bool = true) {
        guard let vc = factory?.viewController(for: route) else { return }
        (navigationController ?? defaultNavigationController)?.pushViewController(vc, animated: animated)
    }

    public func present(_ route: AppRoute, in navigationController: UINavigationController? = nil, animated: Bool = true) {
        guard let vc = factory?.viewController(for: route) else { return }
        (navigationController ?? defaultNavigationController)?.present(vc, animated: animated)
    }
    
    public func tabTo(index: Int) {
        tabBarController?.selectedIndex = index
    }
    
    public func popToRootAndShowTab(index: Int) {
        guard let tabBar = tabBarController else { return }
        tabBar.selectedIndex = index

        if let nav = (tabBar.viewControllers?[index] as? UINavigationController) {
            nav.popToRootViewController(animated: true)
        }
    }
}
