//
//  PaymentsView.swift
//  PaymeFituares
//
//  Created by Asadbek Yoldoshev on 4/3/25.
//

import SwiftUI
import Core

public struct PaymentsView: View {
    
    @State private var text: String = ""
    @FocusState private var isTextFocused: Bool
    @State private var hasReceivers: Bool = false
        
    public init() { }
    
    public var body: some View {
        VStack(spacing: 50) {
            TransferTextField()
            Receivers()
            BottomButtons()
        }
        .padding()
        .padding(.top, 30)
        .navigationTitle("Перевод средств")
        .navigationBarTitleDisplayMode(.inline)
        .background(.secondarySystemBackground)
        .hideKeyboardWhenTappedAround()
        .toolbar(content: Toolbar)
    }
    
    @ViewBuilder
    private func TransferTextField() -> some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Кому:")
                .fontWeight(.semibold)
            
            VStack {
                Text("Номер карты или телефона")
                    .padding(.leading)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(isTextFocused ? .appPrimary : .secondaryLabel)

                HStack {
                    Image(systemName: "rectangle.fill.on.rectangle.fill")
                        .foregroundStyle(Color(UIColor.lightGray))
                    
                    TextField("Номер карты или телефона", text: $text)
                        .focused($isTextFocused)
                        .keyboardType(.numberPad)
                    
                    Image(systemName: "barcode.viewfinder")
                }
                .padding()
                .background(.systemBackground)
                .clipShape(.rect(cornerRadius: 12))
                .setStroke(color: isTextFocused ? .appPrimary : .separator, cornerRadius: 12)
            }
        }
    }
    
    @ViewBuilder
    private func Receivers() -> some View {
        VStack(alignment: .leading) {
            VStack {
                if !hasReceivers {
                    Button {
                        //
                    } label: {
                        VStack {
                            Image(systemName: "plus.square.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.appPrimary)
                                .frame(maxWidth: 24, maxHeight: 24)
                            
                            Text("Добавить")
                                .font(.caption)
                                .foregroundStyle(.secondaryLabel)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                } else {
                    ScrollView(.horizontal) {
                        
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 100)
            
            NavigationLink {
                //
            } label: {
                Text("Все получатели")
                    .fontWeight(.semibold)
                    .foregroundStyle(.appPrimary)
            }
            .fillSuperview()
        }
        .fillSuperview()
    }
    
    @ViewBuilder
    private func BottomButtons() -> some View {
        VStack(spacing: 16) {
            VStack(spacing: 0) {
                NavigationLink {
                    
                } label: {
                    CustomButton(
                        image: "phone",
                        title: "По номеру телефона",
                        accessory: "chevron.right"
                    )
                }
                
                
                Divider()
                    .padding(.leading, 50)
                
                NavigationLink {
                    
                } label: {
                    CustomButton(
                        image: "creditcard",
                        title: "Перевод на мою карту",
                        accessory: "chevron.right"
                    )
                }
                
                Divider()
                    .padding(.leading, 50)
                
                NavigationLink {
                    PayShareView()
                } label: {
                    CustomButton(
                        image: "target",
                        title: "Перевод по Pay Share",
                        accessory: "chevron.right"
                    )
                }
            }
            .background(.tertiarySystemBackground)
            .clipShape(.rect(cornerRadius: 16))
            
            Button {
                
            } label: {
                CustomButton(
                    image: "rectangle.portrait.on.rectangle.portrait.angled",
                    title: "Добавить открытку",
                    accessory: "plus"
                )
            }
        }
    }
    
    @ViewBuilder
    private func CustomButton(image: String, title: String, accessory: String) -> some View {
        HStack(spacing: 16) {
            Image(systemName: image)
                .foregroundStyle(.appPrimary)
            
            Text(title)
                .foregroundStyle(.label)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: accessory)
                .foregroundStyle(.secondaryLabel)
        }
        .padding()
        .background(.tertiarySystemBackground)
        .clipShape(.rect(cornerRadius: 16))
    }
    
    @ToolbarContentBuilder
    private func Toolbar() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                //
            } label: {
                Image(systemName: "exclamationmark.shield.fill")
                    .padding(4)
                    .foregroundStyle(.white)
                    .background(.appPrimary)
                    .clipShape(.circle)
            }
        }
    }
}

#Preview {
    NavigationView {
        PaymentsView()
    }
}
