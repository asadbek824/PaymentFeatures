//
//  PeerDevice.swift
//  Core
//
//  Created by Akbarshah Jumanazarov on 4/4/25.
//

import Foundation
import MultipeerConnectivity

public struct PeerDevice: Identifiable, Equatable {
    public let id: MCPeerID
    public var name: String { id.displayName }
    public var isConnected: Bool = false
    
    public static func == (lhs: PeerDevice, rhs: PeerDevice) -> Bool {
        return lhs.id == rhs.id
    }
}
