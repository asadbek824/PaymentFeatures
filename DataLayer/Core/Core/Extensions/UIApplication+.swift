//
//  UIApplication.swift
//  Core
//
//  Created by Asadbek Yoldoshev on 4/16/25.
//

import Foundation
import UIKit
 
public extension UIApplication {
    func topNavController() -> UINavigationController? {
        guard let windowScene = connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first(where: \.isKeyWindow),
              let root = window.rootViewController else { return nil }

        return topNavController(from: root)
    }

    private func topNavController(from root: UIViewController) -> UINavigationController? {
        if let nav = root as? UINavigationController {
            return nav
        } else if let tab = root as? UITabBarController,
                  let selected = tab.selectedViewController {
            return topNavController(from: selected)
        } else if let presented = root.presentedViewController {
            return topNavController(from: presented)
        } else {
            return root.navigationController
        }
    }
}

public extension UIApplication {
    func topTabBarController() -> UITabBarController? {
        return connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .windows
            .first(where: \.isKeyWindow)?
            .rootViewController as? UITabBarController
    }
}

