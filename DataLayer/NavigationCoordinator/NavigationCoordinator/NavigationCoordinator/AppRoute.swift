//
//  AppRoute.swift
//  NavigationCoordinator
//
//  Created by Asadbek Yoldoshev on 4/9/25.
//

import Foundation
import Core
 
public enum AppRoute: Hashable {
    case home
    case payments
    case services
    case payShare
    case detail(title: String)
    case receipt(model: ReceiptModel)
    case transfer
}
