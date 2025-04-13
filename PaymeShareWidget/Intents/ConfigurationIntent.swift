//
//  ConfigurationIntent.swift.swift
//  PaymeFituares
//
//  Created by Asadbek Yoldoshev on 4/11/25.
//

import AppIntents
import WidgetKit

public struct ConfigurationAppIntent: WidgetConfigurationIntent {
    public static var title: LocalizedStringResource { "Nearby Devices" }
    public static var description: IntentDescription {
        "Показывает ближайшие устройства через MultipeerConnectivity"
    }

    public init() {}
}
