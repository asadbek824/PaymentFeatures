//
//  ReceiveView.swift
//  Core
//
//  Created by Sukhrob on 08/04/25.
//

import SwiftUI

public struct ReceiveView: View {

    @State var isActive: Bool = false
    @StateObject var viewModel = ReceiveViewModel()
    
    public var body: some View {
        VStack {
            Button{
                isActive = true
            } label: {
                Text("Show Pop UP")
            }
        }
        .padding()
        
        if isActive{
            CustomDialog(isActive: .constant(true),
                         title: "New Message",
                         message: "Hello, you have a new notification!")
        }
    }
}

struct ReceiveView_Previews: PreviewProvider {
    static var previews: some View {
        ReceiveView()
    }
}
