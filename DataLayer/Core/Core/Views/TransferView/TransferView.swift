//
//  TransferView.swift
//  Core
//
//  Created by Sukhrob on 10/04/25.
//

import SwiftUI

public struct TransferView: View {
    // MARK: - State
    @State private var selectedCard: UserBalanceAndExpensesModel?
    @State private var isCardSheetPresented = false
    @State private var amount: String = ""
    
    // In a real app, you’d fetch these cards from a ViewModel, but here we’re providing them directly.
    private let availableCards: [UserBalanceAndExpensesModel] = [
        UserBalanceAndExpensesModel(
            cartId: UserCarts(
                cartId: 101,
                balance: 10000,
                expenses: 5000,
                cartNumber: "8600064296969696",
                cartName: "UzCard",
                currency: "UZS",
                cardImage: nil
            )
        ),
        UserBalanceAndExpensesModel(
            cartId: UserCarts(
                cartId: 202,
                balance: 800,
                expenses: 300,
                cartNumber: "1234567890123456",
                cartName: "Humo Card",
                currency: "UZS",
                cardImage: nil
            )
        )
    ]

    public init() {
        _selectedCard = State(initialValue: availableCards.first)
    }

    public var body: some View {
        VStack(spacing: 40) {
            // 1. CardNumberField
            CardNumberField(
                card: selectedCard,
                action: {
                    // Tap this button to show bottom sheet of cards
                    isCardSheetPresented = true
                }
            )

            // 2. AmountField
            AmountField(amount: $amount)

            // 3. SubmitButton
            SubmitButton {
                // Handle the transfer action here (e.g., call your ViewModel)
                print("Transferring amount: \(amount) to card: \(selectedCard?.cartId.cartNumber ?? "No Card Selected")")
            }
        }
        
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .sheet(isPresented: $isCardSheetPresented) {
            // Show the bottom sheet with all cards
            CardsBottomSheet(
                cards: availableCards,
                onCardSelected: { selected in
                    // Update the selected card & dismiss the sheet
                    selectedCard = selected
                    isCardSheetPresented = false
                }
            )
            .presentationDetents([.fraction(0.5)])
        }
    }
}

// MARK: - Subviews

/// A button that shows the currently selected card’s info
/// and triggers opening the CardsBottomSheet when tapped.
struct CardNumberField: View {
    let card: UserBalanceAndExpensesModel?
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                if let card = card {
                    // If there's a custom image, show it; otherwise use a default icon
                    if let cardImage = card.cartId.cardImage, !cardImage.isEmpty {
                        Image(cardImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                    } else {
                        Image(systemName: "creditcard.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                    }

                    HStack{
                        Text("\(card.cartId.cartNumber.prefix(6)) **** \(card.cartId.cartNumber.suffix(4))")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                } else {
                    // No card selected yet
                    Text("Номер карты или телефона")
                        .foregroundColor(.white)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.blue)
            .cornerRadius(8)
        }
        .fillSuperview()
    }
}

/// A text field for entering the amount to transfer.
struct AmountField: View {
    @Binding var amount: String

    var body: some View {
        TextField("Сумма перевода", text: $amount)
            .keyboardType(.decimalPad)
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
            )
    }
}

/// A button to submit the transfer.
struct SubmitButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("Продолжить")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .cornerRadius(8)
        }
    }
}

/// A bottom sheet that lists all available cards. Tapping one
/// triggers the onCardSelected callback to inform the parent view.
struct CardsBottomSheet: View {
    let cards: [UserBalanceAndExpensesModel]
    let onCardSelected: (UserBalanceAndExpensesModel) -> Void

    var body: some View {
        NavigationView {
            List(cards, id: \.cartId.cartId) { card in
                Button {
                    onCardSelected(card)
                } label: {
                    HStack {
                        Image(systemName: "creditcard.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.blue)
                        VStack(alignment: .leading) {
                            Text(card.cartId.cartName)
                                .font(.headline)
                            Text("**** \(card.cartId.cartNumber.suffix(4))")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationTitle("Выберите карту")
        }
    }
}

// MARK: - Preview

struct TransferView_Previews: PreviewProvider {
    static var previews: some View {
        TransferView()
    }
}
