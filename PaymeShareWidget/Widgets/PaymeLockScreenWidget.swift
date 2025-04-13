//
//  PaymeLockScreenWidget.swift
//  PaymeFituares
//
//  Created by Asadbek Yoldoshev on 4/11/25.
//

import WidgetKit
import SwiftUI

struct PaymeLockScreenWidget: Widget {
    let kind: String = "PaymeLockScreenWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: LockScreenProvider()) { entry in
            if #available(iOS 17.0, *) {
                LockScreenWidgetView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                LockScreenWidgetView(entry: entry)
                    .padding()
                    .background(.ultraThinMaterial)
            }
        }
        .configurationDisplayName("PayShare Lock")
        .description("Быстрый доступ к PayShare с экрана блокировки")
        .supportedFamilies([.accessoryCircular])
    }
}
