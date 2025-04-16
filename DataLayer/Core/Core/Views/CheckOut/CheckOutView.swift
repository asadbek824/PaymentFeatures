//
//  CheckOutView.swift
//  Core
//
//  Created by Sukhrob on 16/04/25.
//

import SwiftUI

struct CheckOutView: View {
    // Pass in the checkout model which contains the amount and transaction fee.
    let model: CheckOutModel

    var body: some View {
        VStack(spacing: 16) {
            if let total = model.amount {
                Text("Total Amount")
                    .font(.headline)
                Text("\(total.formatted(.currency(code: model.cardInfo.cartId.currency)))")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            } else {
                Text("No amount specified")
                    .font(.title)
            }
            
            // Optional: Display base amount and transaction fee for clarity.
            if let baseAmount = model.amount {
                Text("Base Amount: \(baseAmount.formatted(.currency(code: model.cardInfo.cartId.currency)))")
                    .font(.subheadline)
            }
            Text("Transaction Fee: \(model.transactionFee.formatted(.currency(code: model.cardInfo.cartId.currency)))")
                .font(.subheadline)
        }
        .padding()
        .navigationTitle("Check Out")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a sample card model.
        let sampleCard = UserBalanceAndExpensesModel(
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
        
//         Create a sample CheckOutModel with a sample amount.
        let sampleCheckOutModel = CheckOutModel(cardInfo: sampleCard, transactionFee: 5.0, amount: 1000)
        
        NavigationView {
            CheckOutView(model: sampleCheckOutModel)
        }
    }
}

