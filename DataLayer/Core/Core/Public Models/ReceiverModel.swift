//
//  ReceiverModel.swift
//  Core
//
//  Created by Asadbek Yoldoshev on 4/17/25.
//

import Foundation

public struct ReceiverModel: Codable, Equatable {
    public let user: UserModel
    
    public init(user: UserModel) {
        self.user = user
    }
}
