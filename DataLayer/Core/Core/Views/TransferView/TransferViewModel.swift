//
//  TransferViewModel.swift
//  Core
//
//  Created by Sukhrob on 10/04/25.
//

final class TransferViewModel: ObservableObject {
    
    let card: UserCard
    
    init(card: UserCard) {
        self.card = card
    }
    
    @Published var amountText: String = "" {
        didSet {
            let formatter = amountFormatter
            if let number = formatter.number(from: amountText) {
                amount = number.doubleValue
            } else {
                amount = nil
            }
            print("amountText: \(amountText), parsed: \(amount ?? -1)")
        }
    }

    
    @Published var amount: Double? = nil {
        didSet {
            print("User typed: \(amount ?? 9)")
        }
    }
    @Published var showValidationError: Bool = false
    
    // Preset amounts and formatter remain the same.
    let presetAmounts: [Int] = [1000, 50000, 100000, 200000, 500000]
    
    var amountFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    // Define the transaction fee.
    let transactionFee: Double = 5.0
    
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
        if card.balance < (amount + transactionFee) {
            return "На карте недостаточно средств для совершения перевода с комиссией \(transactionFee)"
        }
        return nil
    }
    
    var isValid: Bool {
        validationError == nil
    }
    
    func submitTransfer() {
        
    }
}
