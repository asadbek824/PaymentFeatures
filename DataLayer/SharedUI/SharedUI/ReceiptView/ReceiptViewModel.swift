//
//  ReceiptViewModel.swift
//  Core
//
//  Created by Sukhrob on 09/04/25.
//

import SwiftUI
import Core
import NavigationCoordinator

final class ReceiptViewModel: ObservableObject {
    
    @Published var paymentStatus: PaymentStatusModel
    let source: NavigationSource

    init(model: PaymentStatusModel, source: NavigationSource) {
        self.paymentStatus = model
        self.source = source
    }
}


