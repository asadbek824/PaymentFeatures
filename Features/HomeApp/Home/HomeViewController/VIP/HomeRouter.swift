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
        navigationCoordinator.navigate(to: .payShare(senderModel: senderModel), from: navigationController)
    }
}
