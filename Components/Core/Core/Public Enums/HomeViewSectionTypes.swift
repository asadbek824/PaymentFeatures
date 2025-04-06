//
//  HomeViewSectionTypes.swift
//  Core
//
//  Created by Asadbek Yoldoshev on 4/4/25.
//

import Foundation

public enum HomeViewSectionTypes: Int, CaseIterable {
    case balance
    case paymeGo
    case banner
//    case popular
    
    public var index: Int {
        switch self {
        case .balance: return .zero
        case .paymeGo: return .one
        case .banner: return .two
//        case .popular: return .three
        }
    }
}

public extension HomeViewSectionTypes {
    
    func getNumberOfItems() -> Int {
        switch self {
        case .balance: .one
        case .paymeGo: .three
        case .banner: .one
        }
    }
}
