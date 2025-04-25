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
import NavigationCoordinator
import WidgetKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private lazy var factory: DefaultNavigationFactory = {
        DefaultNavigationFactory()
    }()
    
    private lazy var navigationCoordinator: AppNavigationCoordinator = {
        let coordinator = AppNavigationCoordinator(factory: factory)
        factory.coordinator = coordinator
        return coordinator
    }()
    
    private var tabBarItemsData: [TabBarItemData] = []
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        
        tabBarItemsData = [
            TabBarItemData(
                image: "house.fill",
                title: "главная",
                type: .uikit(HomeAssemblyImpl.assemble(cordinator: navigationCoordinator))
            ),
            TabBarItemData(
                image: "arrow.left.arrow.right",
                title: "перевод",
                type: .swiftui(AnyView(PaymentsView(coordinator: navigationCoordinator)))
            )
        ]
        
        let tabBarVC = UITabBarController()
        let tabViewControllers = createTabBarItems(tabBarItems: tabBarItemsData)
        tabBarVC.viewControllers = tabViewControllers
        tabBarVC.selectedIndex = 0
        tabBarVC.tabBar.backgroundColor = .white
        tabBarVC.tabBar.tintColor = .appColor.primary
        
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
    
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        if url.scheme == "paymeFeature2", url.host == "pay-share" {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                if let nav = UIApplication.shared.topNavController(),
                   let model = SenderModelCacheImpl.shared.load() {
                    self.navigationCoordinator.navigate(
                        to: .payShare(senderModel: model, source: .homeTab),
                        from: nav
                    )
                }
            }
            return true
        }
        
        return false
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    public func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .sound])
    }
}
