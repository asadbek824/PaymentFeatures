//
//  PaymentStatusModel.swift
//  Core
//
//  Created by Asadbek Yoldoshev on 4/18/25.
//

import Foundation

public struct PaymentStatusModel: Codable, Equatable, Identifiable {
    public var id = UUID()
    public let status: PaymentStatus

    public init(status: PaymentStatus) {
        self.status = status
    }
}
