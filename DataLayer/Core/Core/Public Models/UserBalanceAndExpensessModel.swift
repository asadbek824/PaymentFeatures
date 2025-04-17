//
//  UserBalanceAndExpensessModel.swift
//  Core
//
//  Created by Asadbek Yoldoshev on 4/4/25.
//

import Foundation

public struct UserBalanceAndExpensesModel: Codable, Hashable {
    public let cartId: UserCard
    
    public init(cartId: UserCard) {
        self.cartId = cartId
    }
}

public struct UserCard: Codable, Equatable, Hashable {
    public let cartId: Int
    public let balance: Double
    public let expenses: Double
    public let cartNumber: String
    public let cartName: String
    public let currency: String
    public let cardImage: String?
    
    public init(
        cartId: Int,
        balance: Double,
        expenses: Double,
        cartNumber: String,
        cartName: String,
        currency: String,
        cardImage: String?
    ) {
        self.cartId = cartId
        self.balance = balance
        self.expenses = expenses
        self.cartNumber = cartNumber
        self.cartName = cartName
        self.currency = currency
        self.cardImage = cardImage
    }
}
