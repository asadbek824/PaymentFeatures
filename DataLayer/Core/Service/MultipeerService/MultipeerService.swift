//
//  MultipeerService.swift
//  Core
//
//  Created by Akbarshah Jumanazarov on 4/4/25.
//

import Combine
import Foundation
import MultipeerConnectivity

public class MultipeerService: NSObject {
    
    public static let shared = MultipeerService()
    
    private let serviceType = "payme-pay-share"
    private let myPeerId = MCPeerID(displayName: UIDevice.current.name)
    private var session: MCSession
    private var advertiser: MCNearbyServiceAdvertiser
    private var browser: MCNearbyServiceBrowser
    
    // Callbacks for view model
    public var onPeerDiscovered: ((PeerDevice) -> Void)?
    public var onPeerLost: ((MCPeerID) -> Void)?
    public var onConnectionStatusChanged: ((ConnectionStatus) -> Void)?
    public var onPeersUpdated: (([PeerDevice]) -> Void)?
    public var onMessageReceived: ((PeerMessage) -> Void)?
    
    // Internal state
    private var discoveredPeers: [PeerDevice] = []
    private var connectedPeers: [PeerDevice] = []
    private var messages: [PeerMessage] = []
    private var connectionStatus: ConnectionStatus = .notConnected {
        didSet {
            onConnectionStatusChanged?(connectionStatus)
        }
    }
    
    public override init() {
        print("MultipeerService: Initializing...")
        session = MCSession(peer: myPeerId, securityIdentity: nil, encryptionPreference: .none)
        advertiser = MCNearbyServiceAdvertiser(peer: myPeerId, discoveryInfo: nil, serviceType: serviceType)
        browser = MCNearbyServiceBrowser(peer: myPeerId, serviceType: serviceType)
        
        super.init()
        
        session.delegate = self
        advertiser.delegate = self
        browser.delegate = self
        print("MultipeerService: Initialized with device name: \(myPeerId.displayName)")
    }
    
    public func start() {
        print("MultipeerService: Starting services...")
        stop()
        
        advertiser.startAdvertisingPeer()
        print("MultipeerService: Started advertising")
        
        browser.startBrowsingForPeers()
        print("MultipeerService: Started browsing")
        
        connectionStatus = .searching
    }
    
    public func syncStateToWidget() {
        let names = discoveredPeers.map { $0.name }
        let status = connectionStatus.description
        
        let defaults = UserDefaults(suiteName: "group.AssA.PaymeFituaresApp.PaymeShareWidget")
        defaults?.set(names, forKey: "peerNames")
        defaults?.set(status, forKey: "connectionStatus")
        
        print("💾 Сохранили peers: \(names)")
    }
    
    public func stop() {
        print("MultipeerService: Stopping services...")
        advertiser.stopAdvertisingPeer()
        browser.stopBrowsingForPeers()
        session.disconnect()
        discoveredPeers.removeAll()
        connectedPeers.removeAll()
        connectionStatus = .stopped
        print("MultipeerService: All services stopped")
    }
    
    public func connectToPeer(_ peer: PeerDevice) {
        browser.invitePeer(peer.id, to: session, withContext: nil, timeout: 30)
        connectionStatus = .connecting(to: peer.name)
    }
    
    public func disconnect() {
        session.disconnect()
        updateConnectedPeers()
        connectionStatus = .notConnected
        clearMessages()
    }
    
    public func clearMessages() {
        messages = []
    }
    
    public func sendMessage(_ text: String) -> Bool {
        guard !session.connectedPeers.isEmpty, let data = text.data(using: .utf8) else {
            return false
        }
        
        do {
            try session.send(data, toPeers: session.connectedPeers, with: .reliable)
            print("📤 MultipeerService: Sending message: \(text)")
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.messages.append(PeerMessage(text: text, sender: self.myPeerId.displayName, isFromSelf: true))
                self.onMessageReceived?(PeerMessage(text: text, sender: self.myPeerId.displayName, isFromSelf: true))
            }
            return true
        } catch {
            print("❌ MultipeerService: Error sending message: \(error.localizedDescription)")
            return false
        }
    }
    
    private func updateConnectedPeers() {
        connectedPeers = session.connectedPeers.map { PeerDevice(id: $0, isConnected: true) }
        onPeersUpdated?(connectedPeers)
        
        if !connectedPeers.isEmpty {
            let peerNames = connectedPeers.map { $0.name }.joined(separator: ", ")
            connectionStatus = .connected(to: peerNames)
        } else {
            connectionStatus = .notConnected
        }
        
        for i in 0..<discoveredPeers.count {
            let isConnected = session.connectedPeers.contains(discoveredPeers[i].id)
            discoveredPeers[i].isConnected = isConnected
        }
    }
    
    public func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        print("❌ MultipeerService: Failed to start browsing: \(error.localizedDescription)")
        connectionStatus = .failed(error: "Failed to start browsing")
    }
    
    public func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        print("❌ MultipeerService: Failed to start advertising: \(error.localizedDescription)")
        connectionStatus = .failed(error: "Failed to start advertising")
    }
}

extension MultipeerService: MCSessionDelegate {
    public func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        DispatchQueue.main.async {
            switch state {
            case .connected:
                print("✅ MultipeerService: Connected to \(peerID.displayName)")
                self.connectionStatus = .connected(to: peerID.displayName)
            case .connecting:
                print("⏳ MultipeerService: Connecting to \(peerID.displayName)...")
                self.connectionStatus = .connecting(to: peerID.displayName)
            case .notConnected:
                print("❌ MultipeerService: Disconnected from \(peerID.displayName)")
                self.connectionStatus = .notConnected
            @unknown default:
                print("⚠️ MultipeerService: Unknown state for \(peerID.displayName)")
                self.connectionStatus = .failed(error: "Unknown connection state")
            }
            
            self.updateConnectedPeers()
        }
    }
    
    public func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        guard let text = String(data: data, encoding: .utf8) else { return }
        
        DispatchQueue.main.async { [weak self] in
            print("📥 MultipeerService: Received message from \(peerID.displayName): \(text)")
            let message = PeerMessage(text: text, sender: peerID.displayName, isFromSelf: false)
            self?.messages.append(message)
            self?.onMessageReceived?(message)
        }
    }
    
    public func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {}
    
    public func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {}
    
    public func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {}
}

extension MultipeerService: MCNearbyServiceAdvertiserDelegate {
    
    public func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        print("📨 MultipeerService: Received invitation from peer: \(peerID.displayName)")
        invitationHandler(true, self.session)
    }
}

extension MultipeerService: MCNearbyServiceBrowserDelegate {
    public func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String: String]?) {
        print("✨ MultipeerService: Found peer: \(peerID.displayName)")
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.discoveredPeers.removeAll(where: { $0.id == peerID })
            
            if !self.session.connectedPeers.contains(peerID) {
                let peer = PeerDevice(id: peerID, isConnected: false)
                self.discoveredPeers.append(peer)
                self.onPeerDiscovered?(peer)
                print("📱 MultipeerService: Added new peer to discovered peers: \(peerID.displayName)")
            }
        }
    }
    
    public func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        print("🔍 MultipeerService: Lost peer: \(peerID.displayName)")
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.discoveredPeers.removeAll(where: { $0.id == peerID })
            self.connectedPeers.removeAll(where: { $0.id == peerID })
            self.onPeerLost?(peerID)
            
            if self.connectedPeers.isEmpty {
                switch self.connectionStatus {
                case .searching: break
                default: self.connectionStatus = .notConnected
                }
            }
        }
    }
}
