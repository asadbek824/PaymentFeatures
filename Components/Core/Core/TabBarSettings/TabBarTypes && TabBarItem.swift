//
//  TabBarTypes && TabBarItem.swift
//  Core
//
//  Created by Asadbek Yoldoshev on 4/3/25.
//

import UIKit
import SwiftUI

public enum TabType {
    case uikit(UIViewController)
    case swiftui(AnyView)
    
    public var viewController: UIViewController {
        switch self {
        case .uikit(let vc):
            return vc
        case .swiftui(let view):
            return UIHostingController(rootView: view)
        }
    }
}

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
