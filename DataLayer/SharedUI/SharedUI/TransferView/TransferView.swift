//
//  TransferView.swift
//  Core
//
//  Created by Sukhrob on 10/04/25.
//

import SwiftUI
import Core

// MARK: - TransferView

public struct TransferView: View {
    // MARK: - View Model
    @StateObject private var viewModel: TransferViewModel
    
    @State private var showReceipt = false
    
    public init(receiverModel: ReceiverModel?, senderModel: SenderModel?) {
        _viewModel = StateObject(
            wrappedValue: TransferViewModel(
                receiverModel: receiverModel,
                senderModel: senderModel
            )
        )
    }
    
    public var body: some View {
        ZStack {
            mainContent()
        }
        .fillSuperview()
        .navigationTitle("Перевод")
        .navigationBarTitleDisplayMode(.inline)
        .fullScreenCover(isPresented: $showReceipt) {
            ReceiptView(model: .successPayment, onBack: {  })
        }
    }
    
    @ViewBuilder
    private func mainContent() -> some View {
        VStack(alignment: .leading, spacing: 6) {
            // Header Section with card info.
            CardNumberField(card: viewModel.fixedCard) { }
                .padding(.bottom, 100)
            
            // Amount Input Section.
            HStack {
                Text("Сумма перевода")
                    .font(.callout)
                    .foregroundStyle(.appPrimary)
            }
            AmountField(amount: $viewModel.amount)
                .padding(.bottom, 15)
            
            // Display Validation Error if needed.
            if viewModel.isValid, let _ = viewModel.amount {
                TransactionFee(amount: $viewModel.amount, formatter: viewModel.amountFormatter)
                    .padding(.bottom, 15)
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
            
            // Display Validation Error if needed.
            if let error = viewModel.validationError, viewModel.showValidationError {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }
            
            // Chips Section for preset amounts.
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(viewModel.presetAmounts, id: \.self) { value in
                        Button {
                            viewModel.amount = Double(value)
                            // Hide error message when a preset is selected.
                            viewModel.showValidationError = false
                        } label: {
                            Text("\(value)")
                                .foregroundColor(.secondary)
                                .font(.subheadline)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(16)
                        }
                    }
                }
            }
            .padding(.top, 4)
            
            Spacer()
            
            Button(action: {
                viewModel.submitTransfer()
                showReceipt = true
            }) {
                Text("Продолжить")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.appPrimary)
                    .cornerRadius(8)
            }
            .disabled(!viewModel.isValid)
            .opacity(viewModel.isValid ? 1 : 0.6)
        }
        .padding()
        .background(Color.white)
        .animation(.easeInOut, value: viewModel.isValid)
    }
}

// MARK: - Subviews

/// A button-like view to show the current (and only) card’s info.
struct CardNumberField: View {
    let card: UserBalanceAndExpensesModel?
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                if let card = card,
                   let cardImage = card.cartId.cardImage,
                   !cardImage.isEmpty {
                    Image(cardImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                } else {
                    Image(systemName: "creditcard.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.blue)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    if let card = card {
                        Text(card.cartId.cartName)
                            .font(.headline)
                            .foregroundColor(.primary)
                        let visibleSuffix = card.cartId.cartNumber.suffix(4)
                        Text("** \(visibleSuffix)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    } else {
                        Text("Нет карты")
                            .foregroundColor(.white)
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(8)
        }
    }
}

/// A text field for entering the amount to transfer.
/// Uses a NumberFormatter so that manual input is formatted.
struct AmountField: View {
    @Binding var amount: Double?
    @State private var rawAmount: String
    
    init(amount: Binding<Double?>) {
        self._amount = amount
        // initialize rawAmount from existing binding value
        if let val = amount.wrappedValue {
            self._rawAmount = State(initialValue: String(format: "%.0f", val))
        } else {
            self._rawAmount = State(initialValue: "")
        }
    }
    
    var body: some View {
        TextField("от 1 000 до 15 000 000 сум", text: $rawAmount)
            .keyboardType(.decimalPad)
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .setStroke(color: .appPrimary)
            .foregroundStyle(.label)
            .fontWeight(.medium)
            .onChange(of: rawAmount) { s in
                let cleaned = s.replacingOccurrences(of: " ", with: "")
                amount = Double(cleaned)
            }
        // sync when external binding changes (e.g., chips tapped)
            .onChange(of: amount) { newVal in
                if let v = newVal {
                    rawAmount = String(format: "%.0f", v)
                } else {
                    rawAmount = ""
                }
            }
    }
}

struct TransactionFee: View {
    @Binding var amount: Double?
    let formatter: NumberFormatter
    
    var body: some View {
        let fee = (amount ?? 0) * 0.01
        let formattedFee = formatter.string(from: NSNumber(value: fee)) ?? "0"
        Text("Комиссия: \(formattedFee) сум")
            .font(.caption)
            .foregroundColor(.secondary)
    }
}

// MARK: - Helpers

fileprivate extension Int {
    /// Formats an integer with thousand separators (e.g., “10000” → “10 000”).
    func formattedWithSeparator() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
