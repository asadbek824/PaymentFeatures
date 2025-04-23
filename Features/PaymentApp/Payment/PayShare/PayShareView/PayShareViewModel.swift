//
//  PayShareViewModel.swift
//  Payment
//
//  Created by Akbarshah Jumanazarov on 4/4/25.
//

import Core
import Combine
import Foundation
import NavigationCoordinator
import UIKit

class PayShareViewModel: ObservableObject {
    
    let source: NavigationSource
    let navigationCoordinator: AppNavigationCoordinator
    
    @Published var showSheet: Bool = false
    @Published var senderModel: SenderModel? = nil
    @Published var receiverModel: ReceiverModel? = nil
    @Published var selectedCard: UserCard? = nil
    
    private let multipeerService = MultipeerService.shared
    @Published var discoveredPeers: [PeerDevice] = []
    @Published var connectedPeers: [PeerDevice] = []
    @Published var connectionStatus: ConnectionStatus = .notConnected
    private var cancellables = Set<AnyCancellable>()
    private let notificationService = NotificationService()
    
    init(senderModel: SenderModel, source: NavigationSource, navigationCoordinator: AppNavigationCoordinator) {
        self.senderModel = senderModel
        self.selectedCard = senderModel.selectedCard
        self.source = source
        self.navigationCoordinator = navigationCoordinator
        setupObservers()
        featchReceiverData()
    }
    
    func goToTransfer() {
        guard let nav = UIApplication.shared.topNavController(),
              let sender = senderModel,
              let receiver = receiverModel
        else {
            return
        }
        
        navigationCoordinator.navigate(
            to: .transfer(
                receiverModel: receiver,
                senderModel: sender,
                source: source
            ),
            from: nav
        )
    }
    
    func featchReceiverData() {
        receiverModel = ReceiverModel(
            user: UserModel(id: 1, fullName: "Akbar"),
            receiverCarts: MockData.cards,
            selectedCart: MockData.card
        )
    }
    
    //MARK: - Multipeer Service
    private func setupObservers() {
        multipeerService.onPeerDiscovered = { [weak self] peer in
            self?.discoveredPeers.append(peer)
        }
        
        multipeerService.onPeerLost = { [weak self] peerId in
            self?.discoveredPeers.removeAll(where: { $0.id == peerId })
        }
        
        multipeerService.onConnectionStatusChanged = { [weak self] status in
            self?.connectionStatus = status
        }
        
        multipeerService.onPeersUpdated = { [weak self] connected in
            self?.connectedPeers = connected
        }
        
        multipeerService.onMessageReceived = { [weak self] message in
            if !message.isFromSelf {
                self?.notificationService.scheduleNotification(
                    title: "Входящий перевод",
                    body: "Баланс пополнен на \(message.text) сумов",
                    at: Date().addingTimeInterval(2)
                )
            }
        }
    }
    
    func start() {
        multipeerService.start()
    }
    
    func stop() {
        multipeerService.stop()
    }
    
    func connectToPeer(_ peer: PeerDevice) {
        multipeerService.connectToPeer(peer)
        goToTransfer()
    }
    
    func disconnect() {
        multipeerService.disconnect()
    }
    
    func sendMessage(_ text: String) {
        multipeerService.sendMessage(text)
    }
    
    func clearMessages() {
        multipeerService.clearMessages()
    }
}
