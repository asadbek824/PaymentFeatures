//
//  NetworkService+Extensions.swift
//  NetworkManager
//
//  Created by Asadbek Yoldoshev on 4/3/25.
//

import Foundation

extension NetworkService {
    func log(_ message: Any..., force: Bool = false) {
        #if DEBUG
        if NetworkServiceConfig.isLogEnabled || force {
            print("🌐", message)
        }
        #endif
    }
}
