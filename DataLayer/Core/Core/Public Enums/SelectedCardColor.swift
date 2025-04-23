//
//  SelectedCardColor.swift
//  Core
//
//  Created by Sukhrob Bekmuratov on 4/19/25.
//

import SwiftUI

public enum SelectedCardColor {
    case tbc, humo, uzcard

    public init(from cardName: String) {
        switch cardName.lowercased() {
        case "tbc": self = .tbc
        case "humo": self = .humo
        default: self = .uzcard
        }
    }

    public var gradient: LinearGradient {
        switch self {
        case .tbc:
            return LinearGradient(colors: [Color.blue, Color.purple], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .humo:
            return LinearGradient(colors: [Color.yellow, Color.orange], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .uzcard:
            return LinearGradient(colors: [Color.green, Color.mint], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
}
