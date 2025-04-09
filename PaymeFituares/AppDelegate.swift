//
//  AppDelegate.swift
//  PaymeFituares
//
//  Created by Asadbek Yoldoshev on 4/3/25.
//

import Core
import Home
import UIKit
import SwiftUI
import Payment
import Services
import NavigationCoordinator

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private let tabBarItemsData = [
        TabBarItemData(
            image: "house.fill",
            title: "главная",
            type: .uikit(HomeAssemblyImpl.assemble())
        ),
        TabBarItemData(
            image: "arrow.left.arrow.right",
            title: "перевод",
            type: .swiftui(AnyView(PaymentsView()))
        ),
        TabBarItemData(
            image: "square.grid.2x2",
            title: "сервисы",
            type: .swiftui(AnyView(ServicesView()))
        )
    ]

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        let tabBarVC = UITabBarController()
        let tabViewControllers = createTabBarItems(tabBarItems: tabBarItemsData)
        tabBarVC.viewControllers = tabViewControllers
        tabBarVC.selectedIndex = 0
        tabBarVC.tabBar.backgroundColor = .white
        tabBarVC.tabBar.tintColor = .appColor.primary

        let firstNavVC = tabViewControllers.first as? UINavigationController ?? UINavigationController()

        let factory = DefaultNavigationFactory()
        AppNavigationCoordinator.shared.setRoot(
            navigationController: firstNavVC,
            factory: factory
        )

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarVC
        window?.makeKeyAndVisible()

        return true
    }

    private func createTabBarItems(tabBarItems: [TabBarItemData]) -> [UIViewController] {
        return tabBarItems.map { item in
            let vc = item.type.viewController
            let navVC = UINavigationController(rootViewController: vc)
            navVC.tabBarItem.title = item.title
            navVC.tabBarItem.image = UIImage(systemName: item.image)
            return navVC
        }
    }
}
