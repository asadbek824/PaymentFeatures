//
//  ReceiptViewModel.swift
//  Core
//
//  Created by Sukhrob on 09/04/25.
//

import SwiftUI

/// The ViewModel that provides data and handles interactions on the Payment Success screen
final class ReceiptViewModel: ObservableObject {
    
    /// Published property to notify the view about changes
    @Published var model: ReceiptModel
    
    /// You may inject services or other dependencies here, for example:
    /// private let paymentService: PaymentServiceProtocol
    
    init(model: ReceiptModel /*, paymentService: PaymentServiceProtocol */) {
        self.model = model
        // self.paymentService = paymentService
    }
    
    
    /// Called when one of the bottom actions is tapped
    func onBottomActionTap(_ action: BottomAction) {
        // Handle the bottom action, e.g. show a receipt, save a file, etc.
        print("Bottom action tapped: \(action.text)")
    }
}
