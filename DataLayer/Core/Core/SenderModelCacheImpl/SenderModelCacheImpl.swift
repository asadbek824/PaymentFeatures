//
//  SenderModelCacheImpl.swift
//  Core
//
//  Created by Asadbek Yoldoshev on 4/17/25.
//

import Foundation

protocol SenderModelCacheProtocol {
    func save(sender: SenderModel)
    func load() -> SenderModel?
}

public final class SenderModelCacheImpl: SenderModelCacheProtocol {
    public static let shared = SenderModelCacheImpl()
    public let key = "SenderModelKey"

    public init() { }

    public func save(sender: SenderModel) {
        if let data = try? JSONEncoder().encode(sender) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    public func load() -> SenderModel? {
        guard let data = UserDefaults.standard.data(forKey: key),
              let model = try? JSONDecoder().decode(SenderModel.self, from: data) else {
            return nil
        }
        return model
    }
}
