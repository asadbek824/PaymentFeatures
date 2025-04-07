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
    @Published var connectedPeer: PeerDevice?
    @Published private(set) var multipeerService: MultipeerService?
    @Published var receivedMessage: PeerMessage?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        print("Initializing and starting peer discovery...")
        self.multipeerService = MultipeerService()
        setupSubscriptions()
        multipeerService?.start()
    }
    
    private func setupSubscriptions() {
        multipeerService?.$discoveredPeers
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
            
        multipeerService?.$connectedPeers
            .receive(on: DispatchQueue.main)
            .map { $0.first }
            .sink { [weak self] peer in
                self?.connectedPeer = peer
            }
            .store(in: &cancellables)
        
        multipeerService?.$connectionStatus
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                self?.handleConnectionStatus(status)
            }
            .store(in: &cancellables)
        
        multipeerService?.$messages
             .receive(on: DispatchQueue.main)
             .compactMap { messages -> [PeerMessage] in
                 messages.filter { !$0.isFromSelf }
             }
             .filter { !$0.isEmpty }
             .compactMap { $0.last }
             .sink { [weak self] message in
                 self?.receivedMessage = message
                 self?.multipeerService?.clearMessages()
             }
             .store(in: &cancellables)
    }
    
    private func handleConnectionStatus(_ status: ConnectionStatus) {
        switch status {
        case .notConnected:
            print("notConnected")
        case .searching:
            print("searching")
        case .connecting(let to):
            print("connecting")
        case .connected(let to):
            print("connected")
        case .failed(let error):
            print("failed")
        case .stopped:
            print("stopped")
        @unknown default:
            print("unknown default")
        }
    }
    
    func stopSearching() {
        print("Stopping peer discovery...")
        multipeerService?.stop()
    }
    
    func connect(to peer: PeerDevice) {
        print("Attempting to connect to \(peer.name)")
        multipeerService?.connectToPeer(peer)
        showSheet = true
    }
    
    func disconnect() {
        print("Disconnecting...")
        multipeerService?.disconnect()
    }
    
    func sendMessage(_ text: String) -> Bool {
        guard !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return false
        }
        
        print("Sending message: \(text)")
        return multipeerService?.sendMessage(text) == true ? true : false
    }
}
