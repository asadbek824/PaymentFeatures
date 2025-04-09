//
//  ReceiptView.swift
//  Core
//
//  Created by Sukhrob on 09/04/25.
//

import SwiftUI

struct ReceiptView: View {
    
    @StateObject private var viewModel: ReceiptViewModel
    
    init(model: ReceiptModel) {
        _viewModel = StateObject(wrappedValue: ReceiptViewModel(model: model))
    }
    
    var body: some View {
        VStack(spacing: 50) {
            paymentStatusStack()
            BottomButtons()
        }
        .background(Color(UIColor.secondarySystemBackground))
    }
    
    @ViewBuilder
    private func paymentStatusStack() -> some View {
        VStack {
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
                .foregroundColor(.appPrimary)
            
            Text(viewModel.model.title)
                .font(.headline)
                .fontWeight(.bold)
                .padding(.top, 16)
            
            Text(viewModel.model.description)
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
                .padding(.top, 8)
        }
        .fillSuperview()
        
        
    }
    
    @ViewBuilder
    private func BottomButtons() -> some View {
        HStack(spacing: 16) {
            NavigationLink {
                Text("Phone Transfer") // Replace with actual view
            } label: {
                CustomButton(
                    image: "arrow.left",
                    title: "Назад"
                )
            }
            NavigationLink {
                Text("My Card Transfer") // Replace with actual view
            } label: {
                CustomButton(
                    image: "receipt",
                    title: "Чек"
                )
            }
            NavigationLink {
                Text("Store") // Replace with actual view
            } label: {
                CustomButton(
                    image: "star",
                    title: "Сохранить"
                )
            }
        }
    }
    
    @ViewBuilder
    private func CustomButton(image: String, title: String) -> some View {
        VStack(spacing: 16) {
            Image(systemName: image)
                .foregroundColor(.secondary)
            Text(title)
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .border(.red)

    }
}

// MARK: - PREVIEW

struct ReceiptView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ReceiptView(model: ReceiptModel(title: "Успешно переведено", description: "Вы перевели 1 000 ₽ по номеру телефона"))
        }
    }
}

