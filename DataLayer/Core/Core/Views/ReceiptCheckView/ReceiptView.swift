//
//  ReceiptView.swift
//  Core
//
//  Created by Sukhrob on 09/04/25.
//

import SwiftUI

/// A SwiftUI View representing the Payment Success screen
struct ReceiptView: View {
    
    @ObservedObject var viewModel: ReceiptViewModel
    
    var body: some View {
        VStack {
            
            Spacer()

            // Top checkmark icon (change the image/foregroundColor as desired)
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .frame(width: 70, height: 70)
                .foregroundColor(.cyan)
            
            // Title
            Text(viewModel.model.title)
                .font(.headline)
                .fontWeight(.bold)
                .padding(.top, 16)
            
            // Description or instructions
            Text(viewModel.model.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
                .padding(.top, 8)
            

            
            Spacer()
            
            // Bottom horizontal list of actions/icons
            HStack {
                ForEach(viewModel.model.bottomActions) { action in
                    Button(action: {
                        viewModel.onBottomActionTap(action)
                    }) {
                        VStack(spacing: 4) {
                            Image(systemName: action.iconName)
                                .font(.system(size: 20))
                            Text(action.text)
                                .font(.caption)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
    }
}

struct ReceiptView_Previews: PreviewProvider {
    static var previews: some View {
        
        // Example bottom actions
        let bottomActions = [
            BottomAction(iconName: "arrow.left", text: "В приложении"),
            BottomAction(iconName: "doc.text.fill", text: "Чек"),
            BottomAction(iconName: "star", text: "Сохранить")
        ]
        
        // Example model
        let model = ReceiptModel(
            title: "Оплата успешно проведена",
            description: "В случае несвоевременного получения товара или услуги обратитесь в службу поддержки поставщика",
            bottomActions: bottomActions
        )
        
        // Example ViewModel
        let viewModel = ReceiptViewModel(model: model)
        
        // Pass the ViewModel to the PaymentSuccessView
        return ReceiptView(viewModel: viewModel)
    }
}


