//
//  ReceiverCardPickerSheet.swift
//  SharedUI
//
//  Created by Sukhrob on 18/04/25.
//

import SwiftUI
import Core

public struct ReceiverCardPickerSheet: View {
    @EnvironmentObject var vm: TransferViewModel
    @Environment(\.dismiss) private var dismiss

    
    public var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(vm.receiverModel?.receiverCarts ?? []) { card in
                    let iconName: String = {
                        switch card.cartName.lowercased() {
                        case "tbc": return "TBC"
                        case "humo": return "Humo"
                        default: return "Uzcard"
                        }
                    }()
                    
                    let cardSuffix = String(card.cartNumber.suffix(4))
                    let userName = vm.receiverModel?.user.fullName.uppercased() ?? ""

                    let isSelected = vm.receiverModel?.selectedCart == card

                    Button {
                        withAnimation {
                            vm.receiverModel?.selectedCart = card
                            dismiss()
                        }
                    } label: {
                        HStack {
                            Image(iconName, bundle: .assetsKit)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 38)

                            VStack(alignment: .leading) {
                                Text("**** \(cardSuffix)")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Text(userName)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal)

                            Spacer()
                            if isSelected {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.teal)
                            }
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.gray)
                        }
                        .padding()
                    }

                    Divider()
                        .frame(height: 1)
                        .background(Color.gray.opacity(0.1))
                }
            }
        }
        
    }
}
