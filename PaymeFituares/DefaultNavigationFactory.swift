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
    
    public init() {}
    
    public func makeViewController(for route: AppRoute) -> UIViewController {
        switch route {
        case .payShare(let model):
            let vc = UIHostingController(rootView: PayShareView(senderModel: model))
            vc.hidesBottomBarWhenPushed = true
            return vc
        case .transfer(let receiverModel, let senderModel):
            let vc = UIHostingController(rootView: TransferView(receiverModel: receiverModel, senderModel: senderModel))
            vc.hidesBottomBarWhenPushed = true
            return vc
        case .receipt(let model):
            let receiptView = ReceiptView(model: model) {
                //                NavigationCoordinator.shared.dismissPresented()
            }
            return UIHostingController(rootView: receiptView)
        }
    }
}
