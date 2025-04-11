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

    private var rootTabBarController: UITabBarController?
    private var factory: NavigationFactory?

    public func setRoot(navigationController: UINavigationController, factory: NavigationFactory) {
        self.rootTabBarController = navigationController.tabBarController
        self.factory = factory
    }

    private var currentNavigationController: UINavigationController? {
        guard let selectedViewController = rootTabBarController?.selectedViewController as? UINavigationController else {
            return nil
        }
        return selectedViewController
    }

    public func navigate(to route: AppRoute) {
        guard let vc = factory?.viewController(for: route) else { return }
        vc.hidesBottomBarWhenPushed = true
        currentNavigationController?.pushViewController(vc, animated: true)
    }
    
    public func pop(animated: Bool = true) {
        currentNavigationController?.popViewController(animated: animated)
    }
    
    public func popToRoot(animated: Bool = true) {
        currentNavigationController?.popToRootViewController(animated: animated)
    }
    
    public func pop(to viewController: UIViewController, animated: Bool = true) {
        currentNavigationController?.popToViewController(viewController, animated: animated)
    }
}
