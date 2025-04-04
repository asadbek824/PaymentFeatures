//
//  Message.swift
//  TempDelete
//
//  Created by Akbarshah Jumanazarov on 4/4/25.
//

import Foundation

public struct PeerMessage: Identifiable, Equatable {
    public let id = UUID()
    let text: String
    let sender: String
    let isFromSelf: Bool
    let timestamp = Date()
}
