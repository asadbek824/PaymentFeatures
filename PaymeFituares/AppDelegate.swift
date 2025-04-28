//
//  AppDelegate.swift
//  PaymeFituares
//
//  Created by Asadbek Yoldoshev on 4/3/25.
//

import Core
import UIKit
import SwiftUI
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
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = TabBarController(coordinator: navigationCoordinator)
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        handleDeepLink(url: url)
    }
    
    private func handleDeepLink(url: URL) -> Bool {
        guard url.scheme == "paymeFeature2", url.host == "pay-share" else {
            return false
        }
        
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
}

// MARK: - UNUserNotificationCenterDelegate
extension AppDelegate: UNUserNotificationCenterDelegate {
    public func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .sound])
    }
}
