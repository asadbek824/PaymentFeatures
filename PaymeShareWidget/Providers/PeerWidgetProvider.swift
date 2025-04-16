//
//  PeerWidgetProvider.swift
//  PaymeFituares
//
//  Created by Asadbek Yoldoshev on 4/11/25.
//

import WidgetKit

struct PeerWidgetProvider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> PeerWidgetEntry {
        PeerWidgetEntry(date: Date(), connectionStatus: "Searching...", peerNames: ["Sophie", "William", "Olivia"])
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> PeerWidgetEntry {
        loadEntry()
    }

    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<PeerWidgetEntry> {
        let entry = loadEntry()
        return Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(60)))
    }

    private func loadEntry() -> PeerWidgetEntry {
        let defaults = UserDefaults(suiteName: "group.AssA.PaymeFituaresApp.PaymeShareWidget")
        let status = defaults?.string(forKey: "connectionStatus") ?? "Unknown"
        let peers = defaults?.stringArray(forKey: "peerNames") ?? []
        return PeerWidgetEntry(date: Date(), connectionStatus: status, peerNames: peers)
    }
}
