//
//  Bundle.swift
//  Core
//
//  Created by Asadbek Yoldoshev on 4/6/25.
//

import AssetsKit

public extension Bundle {
    static let assetsKit: Bundle = {
        return Bundle(for: AssetsKitDummy.self)
    }()
}
