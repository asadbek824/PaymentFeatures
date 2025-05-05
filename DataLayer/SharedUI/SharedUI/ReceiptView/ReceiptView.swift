//
//  ReceiptView.swift
//  Core
//
//  Created by Sukhrob on 09/04/25.
//

import SwiftUI
import Core
import NavigationCoordinator

public struct ReceiptView: View {

    @StateObject private var viewModel: ReceiptViewModel
    @Environment(\.dismiss) private var dismiss

    public init(model: PaymentStatusModel, source: NavigationSource) {
        _viewModel = StateObject(wrappedValue: ReceiptViewModel(model: model, source: source))
    }

    public var body: some View {
        VStack(spacing: 0) {
            Spacer()
            statusSection()
            descriptionSection()
            Spacer()
            actionButtonsSection()
        }
        .padding(.top)
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
    }

    // MARK: - Секция статуса
    @ViewBuilder
    private func statusSection() -> some View {
        let status = viewModel.paymentStatus.status

        VStack(spacing: 20) {
            Image(systemName: status.paymentStatusIcon.name)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundColor(status.paymentStatusIcon.color)
            
            Text(status.title)
                .font(.title3.weight(.semibold))
                .multilineTextAlignment(.center)
        }
    }

    // MARK: - Описание
    @ViewBuilder
    private func descriptionSection() -> some View {
        Text(viewModel.paymentStatus.status.description)
            .font(.subheadline)
            .foregroundColor(.gray)
            .multilineTextAlignment(.center)
            .padding(.top, 16)
            .padding(.horizontal)
    }

    // MARK: - Нижние кнопки
    @ViewBuilder
    private func actionButtonsSection() -> some View {
        HStack(spacing: 0) {
            actionButton(icon: "arrow.left", title: "В приложение") { navigateBackToSource()
            }

            actionButton(icon: "doc.text", title: "Чек") {}
            actionButton(icon: "star", title: "Сохранить") {}
        }
        .padding(.horizontal)
        .padding(.bottom, 16)
    }

    private func actionButton(
        icon: String,
        title: String,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.title2)
                Text(title)
                    .font(.footnote)
            }
            .foregroundColor(.gray)
            .frame(maxWidth: .infinity)
        }
    }
}

extension ReceiptView {
    
    private func navigateBackToSource() {
        guard let tabBarController = UIApplication.shared.topTabBarController() else { return }

        switch viewModel.source {
        case .homeTab:
            tabBarController.selectedIndex = 0
        case .paymentTab:
            tabBarController.selectedIndex = 1
        @unknown default:
            fatalError("Unknown navigation source")
        }

        if let nav = tabBarController.selectedViewController as? UINavigationController {
            nav.popToRootViewController(animated: false)
        }

        if let presented = tabBarController.presentedViewController {
            presented.dismiss(animated: true)
        }
    }
}

