//
//  NavigationFactory.swift
//  NavigationCoordinator
//
//  Created by Asadbek Yoldoshev on 4/16/25.
//

import Foundation
import UIKit

public protocol NavigationFactory {
    func makeViewController(for route: AppRoute) -> UIViewController
}
