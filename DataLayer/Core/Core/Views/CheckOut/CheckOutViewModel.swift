//
//  CheckOutViewModel.swift
//  Core
//
//  Created by Sukhrob on 16/04/25.
//

import SwiftUI

class CheckOutViewModel: ObservableObject {
    @Published var checkOutData: CheckOutModel

    init(cardInfo: UserBalanceAndExpensesModel,
         transactionFee: Double) {
        self.checkOutData = CheckOutModel(cardInfo: cardInfo, transactionFee: transactionFee)
    }
    
    // When you need to bind to your view you can expose the amount property.
    var amount: Double? {
        get { checkOutData.amount }
        set { checkOutData.amount = newValue }
    }
    
    // Add your business logic methods here, for example, calculating total after fee.
    var totalAmount: Double? {
        guard let amount = checkOutData.amount else { return nil }
        return amount + checkOutData.transactionFee
    }
}
