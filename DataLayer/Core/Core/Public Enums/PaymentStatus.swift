//
//  PaymentStatus.swift
//  Core
//
//  Created by Asadbek Yoldoshev on 4/18/25.
//

import Foundation
import SwiftUI

public enum PaymentStatus: Codable {
    case success
    case failure
    case pending
    
    public var paymentStatusIcon: (name: String, color: Color) {
        switch self {
        case .success: return ("checkmark.circle.fill", Color.appPrimary)
        case .failure: return ("x.circle.fill", Color.red)
        case .pending: return ("clock.arrow.trianglehead.counterclockwise.rotate.90", Color.orange)
        }
    }
    
    public var title: String {
        switch self {
        case .success: return "Payment Successful"
        case .failure: return "Payment Failed"
        case .pending: return "Payment Pending"
        }
    }

    public var description: String {
        switch self {
        case .success: return "Your payment was processed successfully."
        case .failure: return "Your payment failed. Please try again."
        case .pending: return "Your payment is currently pending."
        }
    }
}
