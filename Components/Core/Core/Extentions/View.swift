//
//  View.swift
//  Core
//
//  Created by Akbarshah Jumanazarov on 4/4/25.
//

import SwiftUI

public extension View {
    
    func fillSuperview(alignment: Alignment = .center) -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
    }
    
    func setStroke(color: Color, lineWidth: CGFloat = 1.0, cornerRadius: CGFloat = 8.0) -> some View {
        self
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(color, lineWidth: lineWidth)
            }
    }
    
    func hideKeyboardWhenTappedAround() -> some View  {
        return self.onTapGesture {
            UIApplication.shared
                .sendAction(
                    #selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil
                )
        }
    }
    
    func backButton(_ action: (() -> Void)? = nil) -> some View {
        self
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        Utils.topViewController()?.dismiss(animated: true)
                    } label: {
                        Image(systemName: "chevron.left")
                            .fontWeight(.semibold)
                            .foregroundStyle(.secondaryLabel)
                    }
                }
            }
    }
}
