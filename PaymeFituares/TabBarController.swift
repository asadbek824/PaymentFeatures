//
//  TabBarController.swift
//  PaymeFituares
//
//  Created by Akbar Jumanazarov on 4/28/25.
//

import UIKit
import Core
import Home
import Payment
import SwiftUI
import NavigationCoordinator

final class TabBarController: UITabBarController {
    
    private let coordinator: AppNavigationCoordinator
    
    init(coordinator: AppNavigationCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        setupTabBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTabBar() {
        let tabBarItems = createTabBarItems()
        viewControllers = tabBarItems
        selectedIndex = 0
        tabBar.backgroundColor = .white
        tabBar.tintColor = .appColor.primary
    }
    
    private func createTabBarItems() -> [UIViewController] {
        let items = [
            TabBarItemData(
                image: "house.fill",
                title: "главная",
                type: .uikit(HomeAssemblyImpl.assemble(cordinator: coordinator))
            ),
            TabBarItemData(
                image: "arrow.left.arrow.right",
                title: "перевод",
                type: .swiftui(AnyView(PaymentsView(coordinator: coordinator)))
            )
        ]
        
        return items.map { item in
            let vc = item.type.viewController
            let navVC = UINavigationController(rootViewController: vc)
            navVC.tabBarItem.title = item.title
            navVC.tabBarItem.image = UIImage(systemName: item.image)
            return navVC
        }
    }
}
