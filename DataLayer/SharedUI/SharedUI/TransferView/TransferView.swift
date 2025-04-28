//
//  TransferView.swift
//  Core
//
//  Created by Sukhrob on 10/04/25.
//

import Core
import NavigationCoordinator
import SwiftUI

public struct TransferView: View {
    
    @StateObject private var viewModel: TransferViewModel
    @FocusState private var isAmountFocused: Bool
    @Environment(\.dismiss) private var dismiss
    
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
            ReceiverCard()
            AmountInput()
            QuickAmounts()
            Spacer()
            ContinueButton()
        }
        .navigationTitle("Перевод")
        .navigationBarTitleDisplayMode(.inline)
        .backButton { dismiss() }
        .sheet(isPresented: $viewModel.showCardSheet) {
            ReceiverCardPickerSheet()
                .environmentObject(viewModel)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
    }
    
    @ViewBuilder
    private func ReceiverCard() -> some View {
        if let receiver = viewModel.receiverModel {
            let card = receiver.selectedCart
            let last4 = card.cartNumber.suffix(4)
            let cardColor = SelectedCardColor(from: card.cartName)
            
            Button {
                viewModel.showCardSheet = true
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(cardColor.gradient)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(receiver.user.fullName)
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
            .padding()

        }
    }
    
    @ViewBuilder
    private func AmountInput() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Сумма перевода")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            TextField("от 1 000 до 15 000 000 сум", text: $viewModel.amount)
                .keyboardType(.numberPad)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.teal, lineWidth: 1)
                }
                .focused($isAmountFocused)
                .onChange(of: viewModel.amount) { newValue in
                    viewModel.formatAmountInput(newValue)
                }
            
            if let feeString = viewModel.feeAmount {
                Text("Комиссия: \(feeString) сум")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            
            if let message = viewModel.validationMessage{
                Text(message)
                    .foregroundColor(.red)
                    .font(.footnote)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: viewModel.feeAmount)
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func QuickAmounts() -> some View {
        let quickAmounts = [1_000, 50_000, 100_000, 200_000]
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(quickAmounts, id: \.self) { amount in
                    Button {
                        viewModel.amount = "\(amount.formattedWithSeparator)"
                        isAmountFocused = false
                    } label: {
                        Text(amount.formattedWithSeparator)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .foregroundColor(.secondaryLabel)
                            .background(.secondarySystemBackground)
                            .cornerRadius(20)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    
    @ViewBuilder
    private func ContinueButton() -> some View {
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
        .padding()
    }
}
