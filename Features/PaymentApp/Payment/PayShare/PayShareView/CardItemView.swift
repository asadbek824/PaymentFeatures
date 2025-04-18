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
        .frame(maxWidth: .infinity, minHeight: 100)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    .red.opacity(0.7),
                    .red                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .cornerRadius(12)
        )
        .padding(.horizontal)
        .padding(.bottom, 40)
    }
}
