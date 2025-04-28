//
//  TransferViewModel.swift
//  Core
//
//  Created by Sukhrob on 10/04/25.
//

import Core
import Combine
import SwiftUI
import NavigationCoordinator

public final class TransferViewModel: ObservableObject {
    
    @Published var receiverModel: ReceiverModel?
    @Published var senderModel: SenderModel?
    @Published var amount: String = ""
    
    @Published var paymentStatus: PaymentStatusModel?
    @Published var selectedCard: UserCard? = nil
    @Published var wasAmountEverValid: Bool = false
    
    private let navigationCoordinator: AppNavigationCoordinator
    private let source: NavigationSource
    
    public init(
        receiverModel: ReceiverModel?,
        senderModel: SenderModel?,
        source: NavigationSource,
        navigationCoordinator: AppNavigationCoordinator
    ) {
        self.receiverModel = receiverModel
        self.senderModel = senderModel
        self.source = source
        self.navigationCoordinator = navigationCoordinator
    }
    
    public enum AmountValidationState {
        case empty
        case nonNumeric
        case tooLow(min: Int)
        case tooHigh(max: Int)
        case valid
    }
    
    /// Current validation state
    public var amountValidationState: AmountValidationState {
        let digits = amount.filter { $0.isWholeNumber }
        guard !digits.isEmpty else { return .empty }
        guard let value = Int(digits) else { return .nonNumeric }
        if value < 1_000 { return .tooLow(min: 1_000) }
        if value > 15_000_000 { return .tooHigh(max: 15_000_000) }
        return .valid
    }
    
    /// Whether the amount is valid
    public var isAmountValid: Bool {
        if case .valid = amountValidationState { return true }
        return false
    }
    
    /// A user-facing validation message, if invalid
    /// A user-facing validation message, if invalid
    public var validationMessage: String? {
        guard wasAmountEverValid else { return nil }
        switch amountValidationState {
        case .empty:
            return "Введите сумму перевода"
        case .nonNumeric:
            return "Сумма должна быть числом"
        case .tooLow(let min):
            return "Минимальная сумма — \(min.formattedWithSeparator) сум"
        case .tooHigh(let max):
            return "Максимальная сумма — \(max.formattedWithSeparator) сум"
        case .valid:
            return nil
        }
    }

    
    /// Форматированная строка комиссии 1%, или nil, если сумма невалидна
    public var feeAmount: String? {
        guard isAmountValid,
              let value = Int(amount.filter({ $0.isWholeNumber }))
        else { return nil }
        let fee = Int(Double(value) * 0.01)
        return numberFormatter.string(from: NSNumber(value: fee))
    }
    
    public func performTransfer() {
        withAnimation(.easeInOut(duration: 0.3)) {
            let model = PaymentStatusModel(status: .success)
            if let nav = UIApplication.shared.topNavController() {
                navigationCoordinator.navigate(to: .receipt(model: model, source: source), from: nav)
            }
        }
        NotificationCenter.default.post(
            name: Notification.Name("TRANSFER"),
            object: nil,
            userInfo: ["amount" : amount]
        )
    }
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.maximumFractionDigits = 0
        return formatter
    }()
    
    func formatAmountInput(_ input: String) {
        let digits = input.filter { $0.isWholeNumber }
        if let number = Int(digits) {
            if let formatted = numberFormatter.string(from: NSNumber(value: number)) {
                if formatted != amount {
                    amount = formatted
                }
            }
            // Track if user ever inputted a valid number
            if number >= 1_000 && number <= 15_000_000 {
                wasAmountEverValid = true
            }
        } else {
            amount = ""
        }
    }

}
