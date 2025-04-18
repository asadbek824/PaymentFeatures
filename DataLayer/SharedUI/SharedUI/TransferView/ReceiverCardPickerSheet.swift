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
    
    public var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(vm.receiverModel?.receiverCarts ?? []) { card in
                    Button {
                        withAnimation {
                            vm.receiverModel?.selectedCart = card
                        }
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(card.cartName.uppercased())
                                    .font(.headline)
                                Text("**** \(card.cartNumber.suffix(4))")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            if vm.receiverModel?.selectedCart == card {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.teal)
                            }
                        }
                        .padding(.vertical, 6)
                    }
                    .navigationTitle("Выберите карту")
                    .navigationBarTitleDisplayMode(.inline)
                }
                //            List(vm.receiverModel?.receiverCarts ?? [], id: \.cartId) { card in
                //                CardItemView(card: card)
                //                    .tag(card)
                ////                }
                ////                .buttonStyle(.plain)
                //            }
                //            .navigationTitle("Выберите карту")
                //            .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}
