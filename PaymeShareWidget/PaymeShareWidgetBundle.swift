//
//  PaymeShareWidgetBundle.swift
//  PaymeShareWidget
//
//  Created by Asadbek Yoldoshev on 4/9/25.
//

import WidgetKit
import SwiftUI
import AppIntents

let appGroupID = "group.AssA.PaymeShareDemo.PaymeShareWidgetDemo"

// MARK: - AppIntent для обновления виджета
struct RefreshPeersIntent: AppIntent {
    static var title: LocalizedStringResource = "Обновить устройства поблизости"
    static var description = IntentDescription("Обновить Multipeer статус и перезапустить поиск")

    func perform() async throws -> some IntentResult {
        print("🔁 RefreshPeersIntent.perform() — обновляем статус")

        let defaults = UserDefaults(suiteName: appGroupID)
        defaults?.setValue("Searching...", forKey: "connectionStatus")

        WidgetCenter.shared.reloadAllTimelines()
        print("📦 WidgetCenter — перезагружен")

        return .result()
    }
}

struct PeerWidgetEntry: TimelineEntry {
    let date: Date
    let connectionStatus: String
    let peerNames: [String]
}

struct PeerWidgetProvider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> PeerWidgetEntry {
        PeerWidgetEntry(date: Date(), connectionStatus: "Searching...", peerNames: ["Test Device"])
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> PeerWidgetEntry {
        loadEntry()
    }

    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<PeerWidgetEntry> {
        let entry = loadEntry()
        return Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(30)))
    }

    private func loadEntry() -> PeerWidgetEntry {
        let defaults = UserDefaults(suiteName: appGroupID)

        let status = defaults?.string(forKey: "connectionStatus") ?? "Unknown"
        let peers = defaults?.stringArray(forKey: "peerNames") ?? []

        print("📥 Widget загружает данные из App Group:")
        print("• connectionStatus = \(status)")
        print("• peerNames = \(peers)")

        return PeerWidgetEntry(date: Date(), connectionStatus: status, peerNames: peers)
    }
}

struct PeerWidgetEntryView: View {
    var entry: PeerWidgetEntry

    var body: some View {
        VStack(alignment: .leading) {
            Text(entry.connectionStatus)
                .font(.headline)
                .foregroundColor(.green)
                .onAppear {
                    print("👀 Виджет отображает статус: \(entry.connectionStatus)")
                }

            if entry.peerNames.isEmpty {
                Text("No nearby devices")
                    .font(.caption)
                    .foregroundColor(.gray)
            } else {
                ForEach(entry.peerNames.prefix(3), id: \ .self) { peer in
                    Text(peer)
                        .font(.subheadline)
                }
            }

            Button(intent: RefreshPeersIntent()) {
                Label("Обновить", systemImage: "arrow.clockwise")
                    .font(.caption)
            }
            .onTapGesture {
                print("button Tapped")
            }
        }
        .padding()
    }
}

struct PeerWidget: Widget {
    let kind: String = "PeerWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: PeerWidgetProvider()) { entry in
            if #available(iOS 17.0, *) {
                PeerWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                PeerWidgetEntryView(entry: entry)
            }
        }
        .configurationDisplayName("Nearby Devices")
        .description("Показывает ближайшие устройства и статус подключения")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

@main
struct PaymeShareWidgetDemoBundle: WidgetBundle {
    var body: some Widget {
        PeerWidget()
    }
}

