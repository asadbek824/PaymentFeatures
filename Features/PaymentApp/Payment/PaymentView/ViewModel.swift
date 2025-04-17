//
//  ViewModel.swift
//  Payment
//
//  Created by Asadbek Yoldoshev on 4/17/25.
//

import Foundation
import Core

final class ViewModel: ObservableObject {
    @Published var senderModel: SenderModel? = nil
    
    init(senderModel: SenderModel? = nil) {
        self.senderModel = senderModel
    }
    
    func onAppear() {
        featchSenderData()
    }
    
    func featchSenderData() {
        senderModel = SenderModel(
            user: UserModel(id: 1, fullName: "AssA"),
            senderCards: [
                UserCard(
                    cartId: 1,
                    balance: 820360.48,
                    expenses: 1200210.24,
                    cartNumber: "8600060905809696",
                    cartName: "Xalq Bank",
                    currency: "сум", cardImage: nil
                ),
                UserCard(
                    cartId: 1,
                    balance: 820360.48,
                    expenses: 1200210.24,
                    cartNumber: "8600060905809696",
                    cartName: "Xalq Bank",
                    currency: "сум", cardImage: nil
                )
            ],
            selectedCard:
                UserCard(
                    cartId: 1,
                    balance: 820360.48,
                    expenses: 1200210.24,
                    cartNumber: "8600060905809696",
                    cartName: "Xalq Bank",
                    currency: "сум", cardImage: nil
                )
        )
    }
}
