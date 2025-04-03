//
//  AppDelegate.swift
//  PaymeFituares
//
//  Created by Asadbek Yoldoshev on 4/3/25.
//

import UIKit
import SwiftUI
import Core
import Home
import Payment

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
        )
    ]

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let tabBarVC = UITabBarController()
        tabBarVC.viewControllers = createTabBarItems(tabBarItems: tabBarItemsData)
        tabBarVC.selectedIndex = 0
        tabBarVC.tabBar.backgroundColor = .white
        tabBarVC.tabBar.tintColor = .appColor.primary
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarVC
        window?.makeKeyAndVisible()
        
        return true
    }
}

extension AppDelegate {
    
    private func createTabBarItems(tabBarItems: [TabBarItemData]) -> [UIViewController] {
        var tabBars: [UIViewController] = []
        
        for item in tabBarItems {
            let viewController = item.type.viewController
            let navVC = UINavigationController(rootViewController: viewController)
            
            navVC.tabBarItem.title = item.title
            navVC.tabBarItem.image = UIImage(systemName: item.image)
            
            tabBars.append(navVC)
        }
        
        return tabBars
    }
}
