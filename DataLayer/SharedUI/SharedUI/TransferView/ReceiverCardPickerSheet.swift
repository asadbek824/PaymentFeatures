//
//  ReceiverCardPickerSheet.swift
//  SharedUI
//
//  Created by Sukhrob on 18/04/25.
//

import Core
import SwiftUI

public struct ReceiverCardPickerSheet: View {
    
    @EnvironmentObject private var vm: TransferViewModel
    @Environment(\.dismiss) private var dismiss
    
    public var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(vm.receiverModel?.receiverCarts ?? []) { card in
                        CardButton(for: card)
                        
                        Divider()
                            .background(Color.gray.opacity(0.1))
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func CardButton(for card: UserCard) -> some View {
        let isSelected = vm.receiverModel?.selectedCart == card
        let iconName = vm.getIconName(for: card.cartName)
        let cardSuffix = card.cartNumber.suffix(4)
        let userName = vm.receiverModel?.user.fullName.uppercased() ?? ""
        
        Button {
            withAnimation {
                vm.receiverModel?.selectedCart = card
                dismiss()
            }
        } label: {
            HStack(spacing: 16) {
                Image(iconName, bundle: .assetsKit)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 38)

                VStack(alignment: .leading, spacing: 4) {
                    Text("**** \(cardSuffix)")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(userName)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.teal)
                }

                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
        }
    }
}
