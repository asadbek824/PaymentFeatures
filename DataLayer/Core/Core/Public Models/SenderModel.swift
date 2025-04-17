//
//  SenderModel.swift
//  Core
//
//  Created by Asadbek Yoldoshev on 4/17/25.
//

import Foundation

public struct SenderModel: Identifiable, Codable, Equatable, Hashable {
    public var id: UUID = UUID()
    public let user: UserModel
    public let senderCards: [UserCard]
    public let selectedCard: UserCard
    
    public init(user: UserModel, senderCards: [UserCard], selectedCard: UserCard) {
        self.user = user
        self.senderCards = senderCards
        self.selectedCard = selectedCard
    }
}
