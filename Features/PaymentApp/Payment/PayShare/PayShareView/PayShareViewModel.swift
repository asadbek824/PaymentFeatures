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
    @Published var senderModel: SenderModel? = nil
    @Published var receiverModel: ReceiverModel? = nil
    @Published private(set) var multipeerService: MultipeerService?
    private var cancellables = Set<AnyCancellable>()
    @Published var selectedCard: UserCard = PreviewData.cards.first!
    
    init(senderModel: SenderModel) {
        print("Initializing and starting peer discovery...")
        self.multipeerService = MultipeerService()
        setupSubscriptions()
        multipeerService?.start()
        self.senderModel = senderModel
    }
    
    func onAppear() {
        
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
        
        multipeerService?.$messages
             .receive(on: DispatchQueue.main)
             .compactMap { messages -> [PeerMessage] in
                 messages.filter { !$0.isFromSelf }
             }
             .filter { !$0.isEmpty }
             .compactMap { $0.last }
             .sink { [weak self] message in
                 
                 let futureDate = Date().addingTimeInterval(2)
                 NotificationService.shared.scheduleNotification(
                    title: "Входящий перевод от \(message.sender)",
                    body: "\(message.text) сумов",
                    at: futureDate
                 )
                 
                 self?.multipeerService?.clearMessages()
             }
             .store(in: &cancellables)
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
    
    func featchReceiverData() {
        receiverModel = ReceiverModel(
            user: UserModel(id: 1, fullName: "Akbar")
        )
    }
}
