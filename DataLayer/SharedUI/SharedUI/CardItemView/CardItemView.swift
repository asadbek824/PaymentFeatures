//
//  CardItemView.swift
//  Payment
//
//  Created by Sukhrob on 17/04/25.
//

import Core
import SwiftUI

public struct CardItemView: View {
    public let card: UserCard
    
    public init(card: UserCard) {
        self.card = card
    }
    
    public var body: some View {
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
