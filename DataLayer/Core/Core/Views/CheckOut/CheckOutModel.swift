//
//  CheckOutModel.swift
//  Core
//
//  Created by Sukhrob on 16/04/25.
//
import Foundation

public struct CheckOutModel: Codable {
    public let cardInfo: UserBalanceAndExpensesModel
    public let transactionFee: Double
    public var amount: Double?
    
    public init(cardInfo: UserBalanceAndExpensesModel,
                transactionFee: Double,
                amount: Double? = nil) {
        self.cardInfo = cardInfo
        self.transactionFee = transactionFee
        self.amount = amount
    }
    
}


