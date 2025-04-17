//
//  SenderModel.swift
//  Core
//
//  Created by Asadbek Yoldoshev on 4/17/25.
//

import Foundation

public struct SenderModel: Codable, Equatable {
    public let user: UserModel
    public let senderCards: [UserCarts]
    public let selectedCard: UserCarts
    
    public init(user: UserModel, senderCards: [UserCarts], selectedCard: UserCarts) {
        self.user = user
        self.senderCards = senderCards
        self.selectedCard = selectedCard
    }
}
