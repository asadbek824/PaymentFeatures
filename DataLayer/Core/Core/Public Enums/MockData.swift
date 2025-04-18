//
//  MockData.swift
//  Core
//
//  Created by Sukhrob on 18/04/25.
//

import Foundation

public enum MockData {
    public static let card: UserCard = UserCard(
        cartId: 1,
        balance: 820360.48,
        expenses: 1200210.24,
        cartNumber: "8600060905809696",
        cartName: "TBC",
        currency: "сум", cardImage: "https://raw.githubusercontent.com/00020647/imagesForPayShare/refs/heads/main/cardBlue.jpg"
    )
    
    public static let cards: [UserCard] = [
            UserCard(
                cartId: 1,
                balance: 820360.48,
                expenses: 1200210.24,
                cartNumber: "8600060905809696",
                cartName: "TBC",
                currency: "сум", cardImage: "https://raw.githubusercontent.com/00020647/imagesForPayShare/refs/heads/main/cardBlue.jpg"
            ),
            UserCard(
                cartId: 2,
                balance: 1050000.20,
                expenses: 1200210.24,
                cartNumber: "8600060905807315",
                cartName: "Humo",
                currency: "сум", cardImage: "https://raw.githubusercontent.com/00020647/imagesForPayShare/refs/heads/main/cardPink.jpg"),
            UserCard(
                cartId: 3,
                balance: 2100000.25,
                expenses: 1200210.24,
                cartNumber: "8600060905809489",
                cartName: "Uzcard",
                currency: "сум", cardImage: "https://raw.githubusercontent.com/00020647/imagesForPayShare/refs/heads/main/cardRed.jpg")
        
        ]
}
