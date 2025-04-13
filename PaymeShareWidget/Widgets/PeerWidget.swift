//
//  PeerWidget.swift
//  PaymeFituares
//
//  Created by Asadbek Yoldoshev on 4/11/25.
//

import WidgetKit
import SwiftUI

struct PeerWidget: Widget {
    let kind: String = "PeerWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: PeerWidgetProvider()) { entry in
            if #available(iOS 17.0, *) {
                PeerWidgetEntryView(entry: entry)
                    .containerBackground(for: .widget) {
                        LinearGradient(
                            colors: [Color(red: 0.00, green: 0.82, blue: 0.85), Color(red: 0.15, green: 0.68, blue: 0.78)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    }
            } else {
                PeerWidgetEntryView(entry: entry)
                    .padding()
                    .background(.ultraThinMaterial)
            }
        }
        .configurationDisplayName("Близкие контакты")
        .description("Показывает ближайшие устройства и статус подключения")
        .supportedFamilies([.systemMedium])
    }
}
