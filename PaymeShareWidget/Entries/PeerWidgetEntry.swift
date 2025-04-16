//
//  PeerWidgetEntry.swift
//  PaymeFituares
//
//  Created by Asadbek Yoldoshev on 4/11/25.
//

import WidgetKit

struct PeerWidgetEntry: TimelineEntry {
    let date: Date
    let connectionStatus: String
    let peerNames: [String]
}
