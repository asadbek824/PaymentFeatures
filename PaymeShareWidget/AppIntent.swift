//
//  AppIntent.swift
//  PaymeShareWidget
//
//  Created by Asadbek Yoldoshev on 4/9/25.
//

import WidgetKit
import AppIntents

public struct ConfigurationAppIntent: WidgetConfigurationIntent {
    public static var title: LocalizedStringResource { "Nearby Devices" }
    public static var description: IntentDescription { "Показывает ближайшие устройства через MultipeerConnectivity" }

    public init() {} // ✅ ОБЯЗАТЕЛЬНО
}
