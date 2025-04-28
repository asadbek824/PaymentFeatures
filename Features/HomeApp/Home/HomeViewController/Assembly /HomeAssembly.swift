//
//  HomeAssembly.swift
//  Home
//
//  Created by Asadbek Yoldoshev on 4/3/25.
//

import Foundation
import NavigationCoordinator

public final class HomeAssemblyImpl: AnyObject {
    
    public static func assemble(cordinator: AppNavigationCoordinator) -> HomeViewController {
        
        let router = HomeRouter(navigationCoordinator: cordinator)
        let presenter = HomePresenter()
        let worker = HomeWorker()
        let interactor = HomeInteractor(presenter: presenter, worker: worker)
        
        let viewController = HomeViewController(
            interactor: interactor,
            router: router
        )
        
        presenter.view = viewController
        router.viewController = viewController
        
        return viewController
    }
}
