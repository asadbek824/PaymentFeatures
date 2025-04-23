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
            senderCards: MockData.cards,
            selectedCard:
                MockData.card
        )
    }
}
