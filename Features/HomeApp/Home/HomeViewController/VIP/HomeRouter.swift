//
//  HomeRouter.swift
//  Home
//
//  Created by Asadbek Yoldoshev on 4/3/25.
//

import UIKit
import NavigationCoordinator
import Core

protocol HomeRoutingProtocol {
    func routeToPayShare(senderModel: SenderModel)
    func routeToPayShareIntro()
}

final class HomeRouter {
    
    weak var viewController: UIViewController?
    private let navigationCoordinator: AppNavigationCoordinator
    var navigationController: UINavigationController? {
        viewController?.navigationController
    }
    
    init(viewController: UIViewController? = nil, navigationCoordinator: AppNavigationCoordinator) {
        self.viewController = viewController
        self.navigationCoordinator = navigationCoordinator
    }
    
}

extension HomeRouter: HomeRoutingProtocol {
    
    func routeToPayShare(senderModel: SenderModel) {
        navigationCoordinator.navigate(to: .payShare(senderModel: senderModel, source: .homeTab), from: navigationController)
    }
    
    func routeToPayShareIntro() {
        navigationCoordinator.navigate(to: .payShareIntro, from: navigationController)
    }
}
