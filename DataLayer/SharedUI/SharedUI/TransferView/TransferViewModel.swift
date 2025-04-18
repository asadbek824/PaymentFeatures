//
//  TransferViewModel.swift
//  Core
//
//  Created by Sukhrob on 10/04/25.
//

import Core
import Combine
import SwiftUI

public final class TransferViewModel: ObservableObject {
    
    @Published var receiverModel: ReceiverModel?
    @Published var senderModel: SenderModel?
    @Published var amount: String = ""
    @Published var isReciptPresented: Bool = false
    
    public init(receiverModel: ReceiverModel?, senderModel: SenderModel?) {
        self.receiverModel = receiverModel
        self.senderModel = senderModel
    }
    
    public var isAmountValid: Bool {
        guard let value = Int(amount.filter(\.isWholeNumber)) else { return false }
        return value >= 1_000 && value <= 15_000_000
    }
    
    public func performTransfer() {
        withAnimation(.easeInOut(duration: 0.3)) {
            isReciptPresented = true
        }
    }
}
