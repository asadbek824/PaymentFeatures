//
//  Card.swift
//  Core
//
//  Created by Sukhrob on 16/04/25.
//

import Foundation

public enum PreviewData {
    
    public static let card: UserCard = UserCard(
        cartId: 1,
        balance: 820360.48,
        expenses: 1200210.24,
        cartNumber: "860006090580969",
        cartName: "Xalq Bank",
        currency: "сум", cardImage: nil
    )
        
    public static let cards: [UserCard] = [
        UserCard(
            cartId: 1,
            balance: 820360.48,
            expenses: 1200210.24,
            cartNumber: "8600060905809696",
            cartName: "Ipoteka Bank",
            currency: "сум", cardImage: nil
        ),
        UserCard(
            cartId: 2,
            balance: 820360.48,
            expenses: 1200210.24,
            cartNumber: "8600060905809695",
            cartName: "Xalq Bank",
            currency: "сум", cardImage: nil
        ),
        UserCard(
            cartId: 3,
            balance: 820360.48,
            expenses: 1200210.24,
            cartNumber: "8600060905809694",
            cartName: "AgroBank",
            currency: "сум", cardImage: nil
        )
    ]
}
