//
//  Color.swift
//  Core
//
//  Created by Akbarshah Jumanazarov on 4/4/25.
//

import SwiftUI

public extension Color {
    static let systemBackground = Color(UIColor.systemBackground)
    static let secondarySystemBackground = Color(UIColor.secondarySystemBackground)
    static let tertiarySystemBackground = Color(UIColor.tertiarySystemBackground)
    static let label = Color(UIColor.label)
    static let secondaryLabel = Color(UIColor.secondaryLabel)
    static let separator = Color(UIColor.separator)
    
    static let appPrimary = Color(UIColor.appColor.primary)
}

public extension ShapeStyle where Self == Color {
    static var systemBackground: Color { .systemBackground }
    static var secondarySystemBackground: Color { .secondarySystemBackground }
    static var tertiarySystemBackground: Color { .tertiarySystemBackground }
    static var label: Color { .label }
    static var secondaryLabel: Color { .secondaryLabel }
    static var separator: Color { .separator }
    
    static var appPrimary: Color { .appPrimary }
}
