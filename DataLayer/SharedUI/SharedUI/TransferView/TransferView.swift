//
//  TransferView.swift
//  Core
//
//  Created by Sukhrob on 10/04/25.
//

import SwiftUI
import Core
import NavigationCoordinator

public struct TransferView: View {
    
    @StateObject private var viewModel: TransferViewModel
    @FocusState private var isAmountFocused: Bool
    @Environment(\.dismiss) private var dismiss
    @State private var showCardSheet = false
    
    public init(
        receiverModel: ReceiverModel?,
        senderModel: SenderModel?,
        source: NavigationSource,
        navigationCoordinator: AppNavigationCoordinator
    ) {
        _viewModel = StateObject(
            wrappedValue: TransferViewModel(
                receiverModel: receiverModel,
                senderModel: senderModel,
                source: source,
                navigationCoordinator: navigationCoordinator
            )
        )
    }
    
    public var body: some View {
        VStack(spacing: 24) {
            receiverCard()
                .padding()
            amountInput()
                .padding(.horizontal)
            quickAmounts()
            Spacer()
            continueButton()
                .padding()
        }
        .navigationTitle("Перевод")
        .navigationBarTitleDisplayMode(.inline)
        .backButton { dismiss() }
        .sheet(isPresented: $showCardSheet) {
            ReceiverCardPickerSheet(
                cards: viewModel.receiverModel?.receiverCarts ?? [],
                selectedCard: viewModel.receiverModel?.selectedCart
            ) { selected in
                viewModel.receiverModel?.selectedCart = selected
                showCardSheet = false
            }
        }
    }
    
    @ViewBuilder
    private func receiverCard() -> some View {
        if let receiver = viewModel.receiverModel {
            let card = receiver.selectedCart
            let last4 = card.cartNumber.suffix(4)

            Button {
                showCardSheet = true
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.teal.opacity(0.9), Color.cyan]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )

                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(card.cartName.uppercased())
                                .font(.headline)
                                .foregroundColor(.white)

                            Text("**** \(last4)")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.9))
                        }

                        Spacer()

                        Image(systemName: "chevron.down")
                            .foregroundColor(.white.opacity(0.8))
                            .imageScale(.medium)
                    }
                    .padding()
                }
                .frame(height: 100)
            }
            .buttonStyle(.plain)
        }
    }

    @ViewBuilder
    private func amountInput() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Сумма перевода")
                .font(.subheadline)
                .foregroundColor(.gray)

            TextField("от 1 000 до 15 000 000 сум", text: $viewModel.amount)
                .keyboardType(.numberPad)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.teal, lineWidth: 1))
                .focused($isAmountFocused)
        }
    }

    @ViewBuilder
    private func quickAmounts() -> some View {
        let quickAmounts = [1_000, 50_000, 100_000, 200_000]
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(quickAmounts, id: \.self) { amount in
                    Button(action: {
                        viewModel.amount = "\(amount.formattedWithSeparator)"
                        isAmountFocused = false
                    }) {
                        Text(amount.formattedWithSeparator)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color(.systemGray5))
                            .cornerRadius(20)
                    }
                }
            }
            .padding(.horizontal)
        }
    }

    @ViewBuilder
    private func continueButton() -> some View {
        Button(action: viewModel.performTransfer) {
            Text("Продолжить")
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.teal)
                .foregroundColor(.white)
                .cornerRadius(14)
        }
        .disabled(!viewModel.isAmountValid)
        .opacity(viewModel.isAmountValid ? 1 : 0.5)
    }
}

struct ReceiverCardPickerSheet: View {
    let cards: [UserCard]
    let selectedCard: UserCard?
    let onSelect: (UserCard) -> Void

    var body: some View {
        NavigationStack {
            List(cards, id: \.self) { card in
                Button {
                    onSelect(card)
                } label: {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(card.cartName.uppercased())
                                .font(.headline)
                            Text("**** \(card.cartNumber.suffix(4))")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        if selectedCard == card {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.teal)
                        }
                    }
                    .padding(.vertical, 6)
                }
                .buttonStyle(.plain)
            }
            .navigationTitle("Выберите карту")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
