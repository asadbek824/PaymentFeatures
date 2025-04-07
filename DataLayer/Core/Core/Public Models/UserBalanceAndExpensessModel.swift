//
//  UserBalanceAndExpensessModel.swift
//  Core
//
//  Created by Asadbek Yoldoshev on 4/4/25.
//

import Foundation

public struct UserBalanceAndExpensesModel: Codable {
    public let cartId: UserCarts
    
    public init(cartId: UserCarts) {
        self.cartId = cartId
    }
}

public struct UserCarts: Codable {
    public let cartId: Int
    public let balance: Double
    public let expenses: Double
    public let cartNumber: String
    public let cartName: String
    public let currency: String
    
    public init(
        cartId: Int,
        balance: Double,
        expenses: Double,
        cartNumber: String,
        cartName: String,
        currency: String
    ) {
        self.cartId = cartId
        self.balance = balance
        self.expenses = expenses
        self.cartNumber = cartNumber
        self.cartName = cartName
        self.currency = currency
    }
}
