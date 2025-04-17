//
//  AppRoute.swift
//  NavigationCoordinator
//
//  Created by Asadbek Yoldoshev on 4/16/25.
//

import Foundation
import Core

public enum AppRoute: Equatable {
    case payShare(senderModel: SenderModel)
    case transfer(receiverModel: ReceiverModel, senderModel: SenderModel)
    case receipt(model: ReceiptModel)
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
