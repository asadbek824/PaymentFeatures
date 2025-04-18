//
//  ReceiverModel.swift
//  Core
//
//  Created by Asadbek Yoldoshev on 4/17/25.
//

import Foundation

public struct ReceiverModel: Equatable {
    public let user: UserModel
    public let receiverCarts: [UserCard]
    public var selectedCart: UserCard
    
    public init(user: UserModel, receiverCarts: [UserCard], selectedCart: UserCard) {
        self.user = user
        self.receiverCarts = receiverCarts
        self.selectedCart = selectedCart
    }
}
