//
//  TabBarItemData.swift
//  Core
//
//  Created by Akbarshah Jumanazarov on 4/28/25.
//

import Foundation

public struct TabBarItemData {
    public let image: String
    public let title: String
    public let type: TabType
    
    public init(image: String, title: String, type: TabType) {
        self.image = image
        self.title = title
        self.type = type
    }
}
