//
//  Bundle.swift
//  DesignSystem
//
//  Created by Asadbek Yoldoshev on 4/16/25.
//

import Foundation

public extension Bundle {
    static let assetsKit: Bundle = {
        return Bundle(for: AssetsKitDummy.self)
    }()
}
