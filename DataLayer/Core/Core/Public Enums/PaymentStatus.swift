//
//  receiptStatus.swift
//  Core
//
//  Created by Sukhrob on 10/04/25.
//
import SwiftUI

public enum ReceiptModel: Hashable, Equatable, Displayable {
    
    case successPayment
    case failedPayment
    case pendingPayment

    // Instead of separate properties, combine them here.
    public var iconDetails: (icon: String, color: Color) {
        switch self {
        case .successPayment:
            return ("checkmark.circle.fill", Color.appPrimary)
        case .failedPayment:
            return ("x.circle.fill", Color.red)
        case .pendingPayment:
            return ("clock.arrow.trianglehead.counterclockwise.rotate.90", Color.orange)
        }
    }
    
    // Computed property for title.
    public var title: String {
        switch self {
        case .successPayment:
            return "Payment Successful"
        case .failedPayment:
            return "Payment Failed"
        case .pendingPayment:
            return "Payment Pending"
        }
    }

    // Computed property for description.
    public var description: String {
        switch self {
        case .successPayment:
            return "Your payment was processed successfully."
        case .failedPayment:
            return "Your payment failed. Please try again."
        case .pendingPayment:
            return "Your payment is currently pending."
        }
    }
}
