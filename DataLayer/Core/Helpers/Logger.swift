//
//  Logger.swift
//  Core
//
//  Created by Akbarshah Jumanazarov on 5/5/25.
//

import Foundation

public struct Logger {
    
    public init() {}
    
    public static func log(_ message: String) {
        #if DEBUG
        print("\(message)")
        #endif
    }
}
