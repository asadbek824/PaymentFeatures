//
//  TransferViewModel.swift
//  Core
//
//  Created by Sukhrob on 10/04/25.
//

import Core
import Combine
import SwiftUI
import NavigationCoordinator

public final class TransferViewModel: ObservableObject {
    
    @Published var receiverModel: ReceiverModel?
    @Published var senderModel: SenderModel?
    @Published var amount: String = ""
    @Published var paymentStatus: PaymentStatusModel?
    @Published var selectedCard: UserCard? = nil
    
    private let navigationCoordinator: AppNavigationCoordinator
    private let source: NavigationSource
    
    public init(
        receiverModel: ReceiverModel?,
        senderModel: SenderModel?,
        source: NavigationSource,
        navigationCoordinator: AppNavigationCoordinator
    ) {
        self.receiverModel = receiverModel
        self.senderModel = senderModel
        self.source = source
        self.navigationCoordinator = navigationCoordinator
    }
    
    public var isAmountValid: Bool {
        guard let value = Int(amount.filter(\.isWholeNumber)) else { return false }
        return value >= 1_000 && value <= 15_000_000
    }
    
    public func performTransfer() {
        withAnimation(.easeInOut(duration: 0.3)) {
            let model = PaymentStatusModel(status: .success)
            if let nav = UIApplication.shared.topNavController() {
                navigationCoordinator.navigate(to: .receipt(model: model, source: source), from: nav)
            }
        }
    }
}
