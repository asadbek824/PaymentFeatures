//
//  PaymeLockScreenWidget.swift
//  PaymeFituares
//
//  Created by Asadbek Yoldoshev on 4/11/25.
//

import WidgetKit
import SwiftUI

struct PaymeLockScreenWidget: Widget {
    let kind: String = "LockScreen_Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                LockScreen_WidgetEntryView(entry: entry)
                    .containerBackground(for: .widget) {
                        LinearGradient(
                            colors: [Color(red: 0.00, green: 0.82, blue: 0.85), Color(red: 0.15, green: 0.68, blue: 0.78)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    }
            } else {
                LockScreen_WidgetEntryView(entry: entry)
                    .padding()
                    .background(.ultraThinMaterial)
            }
        }
        .configurationDisplayName("Pay Share")
        .description("Payme Pay Share feature widget.")
        .supportedFamilies([.accessoryCircular])
    }
}
