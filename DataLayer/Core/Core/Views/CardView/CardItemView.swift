//
//  CardItemView.swift
//  Payment
//
//  Created by Sukhrob on 17/04/25.
//

import Core
import SwiftUI

struct CardItemView: View {
    let card: UserCard
    
    var body: some View {
        HStack {
            // Left column: Card info text
            VStack(alignment: .leading, spacing: 8) {
                Text(card.cartName)
                    .font(.headline)
                    .foregroundColor(.white)
                Text("Баланс: \(card.balance, specifier: "%.0f") \(card.currency)")
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
            
            Spacer()
            // Right column: Masked card number
            VStack(alignment: .trailing) {
                Text("**** \(card.cartNumber.suffix(4))")
                    .font(.system(.callout, design: .monospaced))
                    .foregroundColor(.white)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 120)
        .background {
            AsyncImage(url: URL(string: card.cardImage ?? ""), scale: 1.0) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
        }
        .clipShape(.rect(cornerRadius: 20))
        .padding(.horizontal)
        .padding(.bottom, 40)
    }
}

//#Preview {
//    let model = UserCard(
//        cartId: 1,
//        balance: 820360.48,
//        expenses: 1200210.24,
//        cartNumber: "8600060905809696",
//        cartName: "Xalq Bank",
//        currency: "сум", cardImage: "https://raw.githubusercontent.com/00020647/imagesForPayShare/refs/heads/main/cardBlue.jpg"
//    )
//    CardItemView(card: model)
//}
