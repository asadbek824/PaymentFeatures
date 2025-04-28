//
//  AppRoute.swift
//  NavigationCoordinator
//
//  Created by Asadbek Yoldoshev on 4/16/25.
//

import Foundation
import Core

public enum NavigationSource: Equatable {
    case homeTab
    case paymentTab
}

public enum AppRoute: Equatable {
    case payShare(
        senderModel: SenderModel,
        source: NavigationSource
    )
    case transfer(
        receiverModel: ReceiverModel,
        senderModel: SenderModel,
        source: NavigationSource
    )
    case receipt(
        model: PaymentStatusModel,
        source: NavigationSource
    )
    case payShareIntro
}

public extension AppRoute {
    enum PresentationStyle {
        case push
        case presentFullScreen
    }

    var presentationStyle: PresentationStyle {
        switch self {
        case .receipt:
            return .presentFullScreen
        default:
            return .push
        }
    }
}
