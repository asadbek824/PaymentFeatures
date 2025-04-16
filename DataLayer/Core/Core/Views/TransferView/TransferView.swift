//
//  TransferView.swift
//  Core
//
//  Created by Sukhrob on 10/04/25.
//
import SwiftUI

public struct TransferView: View {
    // MARK: - View Model
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: TransferViewModel
    
    // Navigation flag for the CheckOutView.
    @State private var showReceipt = false
    
    public init(card: UserCard) {
        _viewModel = StateObject(wrappedValue: TransferViewModel(card: card))
    }
    
    public var body: some View {
        NavigationView {
            ZStack {
                mainContent()
            }
            .fillSuperview()
            .navigationTitle("Перевод")
            .navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(isPresented: $showReceipt) {
                ReceiptView(model: .successPayment, onBack: {  })
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Отмена") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func mainContent() -> some View {
        VStack(alignment: .leading, spacing: 6) {
            // Header Section with card info.
            CardNumberField(card: viewModel.card) { }
                .padding(.bottom, 100)
            
            // Amount Input Section.
            HStack {
                Text("Сумма перевода")
                    .font(.callout)
                    .foregroundStyle(.appPrimary)
            }
            AmountField(amount: $viewModel.amount, formatter: viewModel.amountFormatter)
                .padding(.bottom, 15)
            
            TransactionFee(amount: $viewModel.amount, formatter: viewModel.amountFormatter)
                .padding(.bottom, 15)
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
                            Text("\(value.formattedWithSeparator())")
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
            
            // Submit Button.
            Button(action: {
                viewModel.submitTransfer()
                // Navigate to CheckOutView by toggling the flag.
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
    }
}

struct CardNumberField: View {
    let card: UserCard?
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                if let card = card,
                   let cardImage = card.cardImage,
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
                        Text(card.cartName)
                            .font(.headline)
                            .foregroundColor(.primary)
                        let visibleSuffix = card.cartNumber.suffix(4)
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

struct AmountField: View {
    @Binding var amount: Double?
    let formatter: NumberFormatter
    
    var body: some View {
        TextField("от 1 000 до 15 000 000 сум", value: $amount, formatter: formatter)
            .keyboardType(.decimalPad)
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .setStroke(color: .appPrimary) // Custom modifier; remove if undefined.
            .foregroundStyle(.label)
            .fontWeight(.medium)
    }
}

struct TransactionFee: View {
    @Binding var amount: Double?
    let formatter: NumberFormatter

    var body: some View {
        let fee = (amount ?? 0) * 0.01
        let formattedFee = formatter.string(from: NSNumber(value: fee)) ?? "0"
        return Text("Комиссия: \(formattedFee) сум")
            .font(.caption)
            .foregroundColor(.secondary)
    }
}

fileprivate extension Int {
    /// Formats an integer with thousand separators (e.g., "10000" → "10 000").
    func formattedWithSeparator() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}


