//
//  ReceiptViewModel.swift
//  Core
//
//  Created by Sukhrob on 09/04/25.
//

import SwiftUI

protocol ReceiptViewModelProtocol: ObservableObject {
    var model: Displayable { get }
}

final class ReceiptViewModel: ReceiptViewModelProtocol {
    @Published var model: Displayable

    init(model: Displayable) {
        self.model = model
    }
}

enum PaymentStatus {
    case successPayment
    case failedPayment
    case pendingPayment

    // Default initializer
    init() {
        self = .pendingPayment
    }

    // Custom initializer to handle string input
    init?(statusString: String) {
        switch statusString.lowercased() {
        case "success":
            self = .successPayment
        case "failed":
            self = .failedPayment
        case "pending":
            self = .pendingPayment
        default:
            return nil
        }
    }

    // Custom initializer to handle integer input
    init?(statusCode: Int) {
        switch statusCode {
        case 1:
            self = .successPayment
        case 2:
            self = .failedPayment
        case 3:
            self = .pendingPayment
        default:
            return nil
        }
    }
}

