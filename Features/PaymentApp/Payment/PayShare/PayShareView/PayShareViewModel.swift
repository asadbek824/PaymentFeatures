//
//  PayShareViewModel.swift
//  Payment
//
//  Created by Akbarshah Jumanazarov on 4/4/25.
//

import Core
import Combine
import Foundation

class PayShareViewModel: ObservableObject {
    
    @Published var showSheet: Bool = false
    @Published var multipeerService = MultipeerService()
    @Published var messageText = ""
    @Published var isConnecting = false
    @Published var showPeerList = false
    
    init() {
        print("Initializing and starting peer discovery...")
        multipeerService.start()
        multipeerService.onConnectionStatusChanged = { [weak self] status in
            self?.isConnecting = status.contains("Connecting")
        }
    }
    
    func stopSearching() {
        print("Stopping peer discovery...")
        multipeerService.stop()
    }
    
    func connect(to peer: PeerDevice) {
        print("Attempting to connect to \(peer.name)")
        isConnecting = true
        multipeerService.connectToPeer(peer)
    }
    
    func disconnect() {
        print("Disconnecting...")
        multipeerService.disconnect()
    }
    
    func sendMessage() {
        guard !messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        print("Sending message: \(messageText)")
        if multipeerService.sendMessage(messageText) {
            messageText = ""
        }
    }
    
}
