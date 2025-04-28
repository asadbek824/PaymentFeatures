//
//  ViewModel.swift
//  Payment
//
//  Created by Asadbek Yoldoshev on 4/17/25.
//

import Core
import NavigationCoordinator
import UIKit

final class PaymentsViewViewModel: ObservableObject {
    
    @Published var senderModel: SenderModel? = nil
    @Published var text: String = ""
    @Published var hasReceivers: Bool = false
    private let coordinator: AppNavigationCoordinator
    
    init(coordinator: AppNavigationCoordinator, senderModel: SenderModel? = nil) {
        self.coordinator = coordinator
        self.senderModel = senderModel
    }
    
    func onAppear() {
        featchSenderData()
    }
    
    func navigateToPayShare() {
        if let nav = UIApplication.shared.topNavController() {
            coordinator.navigate(to: .payShare(senderModel: senderModel!, source: .paymentTab), from: nav)
        }
    }
    
    private func featchSenderData() {
        senderModel = SenderModel(
            user: UserModel(id: 1, fullName: "AssA"),
            senderCards: MockData.cards,
            selectedCard:
                MockData.card
        )
    }
}
