//
//  HomeAssembly.swift
//  Home
//
//  Created by Asadbek Yoldoshev on 4/3/25.
//

import Foundation

protocol HomeAssemblyProtocol {  }

public final class HomeAssemblyImpl: AnyObject {
    
    public static func assemble() -> HomeViewController {
        
        let router = HomeRouter()
        let presenter = HomePresenter()
        let worker = HomeWorker()
        let interactor = HomeInteractor(presenter: presenter, worker: worker)
        
        let viewController = HomeViewController(interactor: interactor, router: router)
        
        presenter.view = viewController
        router.viewController = viewController
        
        return viewController
    }
}

extension HomeAssemblyImpl: HomeAssemblyProtocol {
    
}
