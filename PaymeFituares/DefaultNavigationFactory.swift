//
//  DefaultNavigationFactory.swift
//  PaymeFituares
//
//  Created by Asadbek Yoldoshev on 4/9/25.
//

import Home
import Payment
import SwiftUI
import NavigationCoordinator
import Core
import SharedUI

public final class DefaultNavigationFactory: NavigationFactory {
    public weak var coordinator: AppNavigationCoordinator?

    public init() {}

    public func makeViewController(for route: AppRoute) -> UIViewController {
        switch route {
        case .payShare(let model, let source):
            let vc = UIHostingController(
                rootView: PayShareView(
                    senderModel: model,
                    source: source,
                    navigationCoordinator: coordinator!
                )
            )
            vc.hidesBottomBarWhenPushed = true
            return vc
        case .transfer(let receiverModel, let senderModel, let source):
            let vc = UIHostingController(
                rootView: TransferView(
                    receiverModel: receiverModel,
                    senderModel: senderModel,
                    source: source,
                    navigationCoordinator: coordinator!
                )
            )
            vc.hidesBottomBarWhenPushed = true
            return vc
        case .receipt(let model, let source):
            let vc = UIHostingController(
                rootView: ReceiptView(model: model, source: source)
            )
            return vc
        case .payShareIntro:
            let vc = UIHostingController(rootView: PayShareIntroView())
            vc.hidesBottomBarWhenPushed = true
            return vc
        }
    }
}
