//
//  ReceiptViewModel.swift
//  Core
//
//  Created by Sukhrob on 09/04/25.
//

import SwiftUI

protocol ReceiptViewModelProtocol: ObservableObject {
    var model: Displayable { get }
}

final class ReceiptViewModel: ReceiptViewModelProtocol {
    @Published var model: Displayable

    init(model: Displayable) {
        self.model = model
    }
}


