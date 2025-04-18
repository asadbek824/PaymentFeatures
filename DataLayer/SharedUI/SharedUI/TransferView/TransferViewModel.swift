//
//  TransferViewModel.swift
//  Core
//
//  Created by Sukhrob on 10/04/25.
//

import SwiftUI
import Core

public final class TransferViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var amount: Double? = nil
    @Published var showValidationError: Bool = false
    @Published var receiverModel: ReceiverModel? = nil
    @Published var senderModel: SenderModel? = nil
    
    public init(receiverModel: ReceiverModel?, senderModel: SenderModel?) {
        self.receiverModel = receiverModel
        self.senderModel = senderModel
    }
    
    // A hard-coded card (in a real app, this might be injected or loaded from a service).
    let fixedCard: UserBalanceAndExpensesModel = UserBalanceAndExpensesModel(
        cartId: UserCard(
            cartId: 999,
            balance: 10000,
            expenses: 5000,
            cartNumber: "8600064296969696",
            cartName: "YULDOSHEV A.",
            currency: "UZS",
            cardImage: nil
        )
    )
    
    // Preset amounts for the horizontal "chips" view.
    let presetAmounts: [Int] = [1000, 50000, 100000, 200000, 500000]
    
    // Formatter for the amount.
    var amountFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        return formatter
    }
    
    // MARK: - Validation Logic
    
    /// Returns an error message if validation fails; nil otherwise.
    var validationError: String? {
        guard let amount = amount else {
            return "Пожалуйста, введите сумму перевода"
        }
        if amount < 1000 {
            return "Сумма перевода должна быть не менее 1 000 сум"
        }
        if amount > 15000000 {
            return "Сумма перевода не может превышать 15 000 000 сум"
        }
        // Calculate total required amount including 1% fee.
//        let totalRequired = amount * 1.01
//        if fixedCard.cartId.balance < totalRequired {
//            return "На карте недостаточно средств для совершения перевода с комиссией 1%"
//        }
        return nil
    }
    
    /// Indicates if all validations pass.
    var isValid: Bool {
        validationError == nil
    }
    
    // MARK: - Transfer Action
    
    /// Call this function on submit. It handles transfer logic and logs the result.
    func submitTransfer() {
//        if let error = validationError {
//            print("Validation Error: \(error)")
//            showValidationError = true
//        } else {
//            showValidationError = false
//            
//            let amountValue = amount.flatMap { amountFormatter.string(from: NSNumber(value: $0)) } ?? "0"
//            print("Transferring amount: \(amountValue) to card: \(fixedCard.cartId.cartNumber)")
//            // Place your transfer logic here, for example, calling an API or updating the app state.
//        }
    }
}


