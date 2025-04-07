//
//  Message.swift
//  TempDelete
//
//  Created by Akbarshah Jumanazarov on 4/4/25.
//

import Foundation

public struct PeerMessage: Identifiable, Equatable {
    public let id = UUID()
    public let text: String
    public let sender: String
    public let isFromSelf: Bool
    public let timestamp = Date()
}
